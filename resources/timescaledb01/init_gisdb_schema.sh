#!/bin/bash
#refer: https://github.com/timescale/timescaledb/issues/91
psql --username "$POSTGRES_USER" <<EOF

DROP DATABASE IF EXISTS gisdb_0;
DROP DATABASE IF EXISTS gisdb_1;

CREATE DATABASE  gisdb_0;
CREATE DATABASE  gisdb_1;

\c gisdb_0

CREATE EXTENSION postgis;

CREATE TABLE time_series_0
(id bigint,time TIMESTAMPTZ,lon varchar(100),lat varchar(100));

CREATE TABLE time_series_1
(id bigint,time TIMESTAMPTZ,lon varchar(100),lat varchar(100));

CREATE EXTENSION btree_gist;

create index concurrently time_series_0_r_index on time_series_0 using rtree(lon,lat);

\c gisdb_1
CREATE EXTENSION postgis;

CREATE TABLE time_series_0
(id bigint,time TIMESTAMPTZ,lon varchar(100),lat varchar(100));

CREATE TABLE time_series_1
(id bigint,time TIMESTAMPTZ,lon varchar(100),lat varchar(100));

CREATE EXTENSION btree_gist;

create index concurrently time_series_1_r_index on time_series_1 using rtree(lon,lat);


EOF
