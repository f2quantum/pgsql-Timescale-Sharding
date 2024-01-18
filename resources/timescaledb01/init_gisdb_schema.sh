#!/bin/bash
#refer: https://github.com/timescale/timescaledb/issues/91
psql --username "$POSTGRES_USER" <<EOF

DROP DATABASE IF EXISTS gisdb;
DROP DATABASE IF EXISTS gisdb_0;
DROP DATABASE IF EXISTS gisdb_1;

CREATE DATABASE  gisdb;
CREATE DATABASE  gisdb_0;
CREATE DATABASE  gisdb_1;

\c gisdb_0

CREATE TABLE time_series_0
(id bigint,time TIMESTAMPTZ,lon varchar(100),lat varchar(100));

CREATE TABLE time_series_1
(id bigint,time TIMESTAMPTZ,lon varchar(100),lat varchar(100));

\c gisdb_1

CREATE TABLE time_series_0
(id bigint,time TIMESTAMPTZ,lon varchar(100),lat varchar(100));

CREATE TABLE time_series_1
(id bigint,time TIMESTAMPTZ,lon varchar(100),lat varchar(100));

EOF
