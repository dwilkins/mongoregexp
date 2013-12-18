#!/bin/bash

THISDIR=`pwd`
THISFIFO=${THISDIR}/loglines.pipe
mkfifo loglines.pipe
chmod 666 loglines.pipe
bzip2 -dc loglines.txt.bz2 > loglines.pipe &
echo ${THISFIFO}
# find / -ls > /mysql/data/db1/ls.dat &
echo "drop database if exists logs;\
create database logs WITH ENCODING 'SQL_ASCII' TEMPLATE=template0;;
\c logs;
create table loglines ( logline varchar(8292) null );
copy loglines from '${THISFIFO}' DELIMITERS '	';
create index idx_loglines on loglines(logline);
select count(1) from loglines;
\d idx_loglines;" | psql
rm loglines.pipe
