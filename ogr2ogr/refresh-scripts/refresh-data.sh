#!/bin/bash

#
#
# script voor de opslaan van de statische download bestanden en bijwerken atom feeds
# met "refresh-Atom-feeds.sh force" kan de update geforceerd worden

user_name=$(whoami)


force=$2
inifile=$1

. $inifile

echo "$(date) start" >> $log_file

ogrinfo PG:"host=rdw_db_1 user=postgres dbname=rdw_inspire password=postgres" -sql "Drop table $postgis_name;"

ogr2ogr -a_srs EPSG:28992 -f "PostgreSQL" PG:"host=rdw_db_1 user=postgres dbname=rdw_inspire password=postgres" /opt/geoserver/data_dir/workspaces/upload/$postgis_name.shp -nlt PROMOTE_TO_MULTI -mapFieldType Date=String -lco GEOMETRY_NAME=the_geom -lco 'COLUMN_TYPES=maximum_he=numeric(24,15),maximum_le=numeric(24,15),maximum_si=numeric(24,15),maximum_wi=numeric(24,15),maximum_to=numeric(24,15)' -nln ${postgis_name} >> $log_file 2>&1
exitcode=$?
if [ $exitcode -gt 0 ]
then
	logger -f $log_file "Fout opgestreden bij laden shp in PostGIS"
	echo  "Fout opgestreden bij laden shp in PostGIS" >> $log_file
	exit 2
fi


ogrinfo PG:"host=rdw_db_1 user=postgres dbname=rdw_inspire password=postgres" -sql "@/opt/refresh-scripts/shp_table2transform_input.sql"

for srid in ${srs[@]}; do
	gml_temp_location=/tmp/gml/
	gml_file=$file_location/${name_notharmonized}_${srid}_gml.zip
	gml_tmp_file=$gml_temp_location/${name_notharmonized}_${srid}.gml
	shp_temp_location=/tmp/shp/
	zip_file=$file_location/${name_notharmonized}_${srid}.zip
	shp_tmp_file=${shp_temp_location}${file_name}_${srid}.shp
	atom_file=$file_location/${name_notharmonized}_nl.xml
	mkdir -p $gml_temp_location
	mkdir -p $shp_temp_location

	# zorg dat de error output van ogr2ogr in  de log terecht komt
	ogr2ogr -overwrite -f "ESRI Shapefile" $shp_temp_location -s_srs "EPSG:${srid}" -t_srs "EPSG:${srid}" PG:"host=${pgserver} user=${pguser} dbname=${pgdatabase} password=${pgpassword}" -nln ${file_name}_${srid} ${postgis_name} >> $log_file 2>&1
	exitcode=$?
	file_type=$(file -ib $shp_tmp_file)
	echo $file_type
	if [ "$file_type" != "application/octet-stream; charset=binary" ] || [ $exitcode -gt 0 ]
	then
		logger "file:$shp_tmp_file not a shape file"
		echo  "file:$shp_tmp_file not a shape file" >> $log_file
		# sla de inhoud van de 'shapefile' op in de logfile zodat bekeken
		# kan worden wat er fout ging. Volgende iteratie wist de shapefile namelijk
		cat $shp_tmp_file >> $logfile
		exit 3
	else
		# replace geoserver prj file with esri prj file for 28992
		echo x$srid
		if [ x$srid = "x28992" ]
		then
			cp /opt/refresh-scripts/rd.prj ${shp_temp_location}${file_name}_${srid}.prj
		fi
		rm $zip_file
		zip -jm $zip_file ${shp_tmp_file%.*}.*
		echo  "file:$zip_file changed" >> $log_file

	fi

	ogr2ogr -f "GML" $gml_tmp_file -s_srs "EPSG:${srid}" -t_srs "EPSG:${srid}" PG:"host=${pgserver} user=${pguser} dbname=${pgdatabase} password=${pgpassword}" ${postgis_name} >> $log_file 2>&1
	exitcode=$?
	if grep -q Exception $gml_tmp_file  || [ $exitcode -gt 0 ]
	then
					logger -f $log_file "file:$gml_tmp_file not a gml file"
		echo  "file:$gml_tmp_file not a gml file" >> $log_file
		exit 4
	else
		zip -jm $gml_file $gml_tmp_file $gml_tmp_file ${gml_tmp_file%.*}.xsd
		#rm $gml_tmp_file
		echo  "file:$gml_file changed" >> $log_file
	fi

	# get the filesize and change the atom feed
	size_gml=$(stat -c%s $gml_file)
	sed -i -e "/${name_notharmonized}_${srid}.gml/ s/length=\"[0-9]*\"/length=\"${size_gml}\"/g" $atom_file
	size_zip=$(stat -c%s $zip_file)
	sed -i -e "/${name_notharmonized}_${srid}.zip/ s/length=\"[0-9]*\"/length=\"${size_zip}\"/g" $atom_file

done

# remove the rdw_hale_1 container if it exists ('|| true' results in the script not exiting if the command fails)
/usr/host/bin/docker rm rdw_hale_1 || true
# Generate the harmonized gml's using HALE in a separate container
/usr/host/bin/docker run --rm -it --name  rdw_hale_1 --network rdw-inspire --volumes-from proxy_nginx_1 rdw_hale

#zip the gml and update the length

for ftype in RFV LHV; do
   #zip the gml_files
   gml_file=$file_location/RDW-INSPIRE-${ftype}.gml
   zip_file=$file_location/RDW-INSPIRE-${ftype}_gml.zip
   zip -jm $zip_file $gml_file

   # get the filesize and change the atom feed
   size_zip=$(stat -c%s ${zip_file})
   sed -i -e "/RDW-INSPIRE-${ftype}_gml.zip/ s/length=\"[0-9]*\"/length=\"${size_zip}\"/g" $file_location/${name_harmonized}_nl.xml
done

date_now=$(date +%FT%T)
# set metadata date in de atom feeds en de service feed
sed -i "/<updated>/s/<updated>.*<\/updated>/<updated>${date_now}<\/updated>/" $file_location/${name_notharmonized}_nl.xml
sed -i "/<updated>/s/<updated>.*<\/updated>/<updated>${date_now}<\/updated>/" $file_location/${name_harmonized}_nl.xml
sed -i "/<updated>/s/<updated>.*<\/updated>/<updated>${date_now}<\/updated>/" $service_feed

echo "$(date) finished" >> $log_file
