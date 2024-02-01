#!/bin/bash
#refer: https://github.com/timescale/timescaledb/issues/91
psql --username "$POSTGRES_USER" <<EOF

CREATE DATABASE  gisdb_0;
CREATE DATABASE  gisdb_1;

\c gisdb_0

CREATE EXTENSION postgis;
CREATE EXTENSION btree_gist;

CREATE TABLE time_series_0
(id bigint,time TIMESTAMPTZ,lon float,lat float);

CREATE TABLE time_series_1
(id bigint,time TIMESTAMPTZ,lon float,lat float);

CREATE TABLE job_0
(id bigint,start_time TIMESTAMPTZ,end_time TIMESTAMPTZ);

CREATE TABLE job_1
(id bigint,start_time TIMESTAMPTZ,end_time TIMESTAMPTZ);

create index concurrently time_series_0_r_index on time_series_0 using rtree(lon,lat);
create index concurrently time_series_1_r_index on time_series_1 using rtree(lon,lat);

\c gisdb_1
CREATE EXTENSION postgis;
CREATE EXTENSION btree_gist;

CREATE TABLE time_series_0
(id bigint,time TIMESTAMPTZ,lon float,lat float);

CREATE TABLE time_series_1
(id bigint,time TIMESTAMPTZ,lon float,lat float);

CREATE TABLE job_0
(id bigint,start_time TIMESTAMPTZ,end_time TIMESTAMPTZ);

CREATE TABLE job_1
(id bigint,start_time TIMESTAMPTZ,end_time TIMESTAMPTZ);

create index concurrently time_series_0_r_index on time_series_0 using rtree(lon,lat);
create index concurrently time_series_1_r_index on time_series_1 using rtree(lon,lat);

EOF
