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
