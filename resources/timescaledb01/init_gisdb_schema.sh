#!/bin/bash
#refer: https://github.com/timescale/timescaledb/issues/91
psql --username "$POSTGRES_USER" <<EOF

DROP DATABASE IF EXISTS gisdb_0;
DROP DATABASE IF EXISTS gisdb_1;

CREATE DATABASE  gisdb_0;
CREATE DATABASE  gisdb_1;

\c gisdb_0

CREATE EXTENSION postgis;
CREATE EXTENSION btree_gist;

CREATE TABLE time_series_0
(id bigint,time TIMESTAMPTZ,geo geometry);

CREATE TABLE time_series_1
(id bigint,time TIMESTAMPTZ,geo geometry);



create index concurrently time_series_0_r_index on time_series_0 using rtree(geo);
create index concurrently time_series_1_r_index on time_series_1 using rtree(geo);

\c gisdb_1
CREATE EXTENSION postgis;
CREATE EXTENSION btree_gist;

CREATE TABLE time_series_0
(id bigint,time TIMESTAMPTZ,geo geometry);

CREATE TABLE time_series_1
(id bigint,time TIMESTAMPTZ,geo geometry);

create index concurrently time_series_0_r_index on time_series_0 using rtree(geo);
create index concurrently time_series_1_r_index on time_series_1 using rtree(geo);

EOF
