#!/bin/bash

mkfifo loglines.pipe
chmod 666 loglines.pipe
bzip2 -dc loglines.txt.bz2 > loglines.pipe &
# find / -ls > /mysql/data/db1/ls.dat &

echo "drop database if exists logs;\
create database logs;
use logs;
create table loglines ( logline varchar(1024) null ) engine=MyISAM;
load data local infile 'loglines.pipe'
into table loglines
fields terminated by '	';
create index idx_loglines on loglines(logline);
select count(1) from loglines;
show indexes from loglines;" | mysql --user=root --password
rm loglines.pipe
