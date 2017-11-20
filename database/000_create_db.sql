create database rdw_inspire;
\c rdw_inspire

create extension postgis;

CREATE TABLE current_wegvakk_restriction
(
  fid serial NOT NULL,
  the_geom geometry(MultiLineString,28992),
  wvk_id integer,
  valid_from character varying,
  valid_to character varying,
  maximum_he double precision,
  maximum_le double precision,
  maximum_si double precision,
  maximum_wi double precision,
  maximum_to double precision,
  "LZV" character varying,
  CONSTRAINT current_wegvakk_restriction_pkey PRIMARY KEY (fid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE current_wegvakk_restriction
  OWNER TO postgres;

-- Index: geom_idx

-- DROP INDEX geom_idx;

CREATE INDEX geom_idx
  ON current_wegvakk_restriction
  USING gist
  (the_geom);

CREATE SCHEMA inspire_harmonized AUTHORIZATION postgres;

GRANT ALL ON SCHEMA inspire_harmonized TO postgres;
GRANT ALL ON SCHEMA inspire_harmonized TO public;

CREATE SEQUENCE inspire_harmonized.rfv_lhv_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE inspire_harmonized.rfv_lhv_id_seq
  OWNER TO postgres;
