FROM wetransform/hale-cli:3.3.1

MAINTAINER IDgis B.V. <info@idgis.nl>

COPY RDW-INSPIRE-RFV.halex /
COPY RDW-INSPIRE-RFV.halex.alignment.xml /
COPY RDW-INSPIRE-RFV.halex.styles.sld /

COPY RDW-INSPIRE-LHV.halex /
COPY RDW-INSPIRE-LHV.halex.alignment.xml /
COPY RDW-INSPIRE-LHV.halex.styles.sld /

COPY run.sh /
RUN chmod a+x /run.sh

ENTRYPOINT []

CMD /run.sh
#CMD tail -f /dev/null