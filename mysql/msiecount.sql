flush tables;
set profiling=1;
select count(1) from loglines where logline regexp 'MSIE ([0-9]{1,}[\.0-9]{0,})';
set profiling=0;
select query_id,'msiecount' as "Query",@rows as "Row Count", ceiling(sum(duration * 1000)) as msecs from information_schema.profiling group by query_id;
