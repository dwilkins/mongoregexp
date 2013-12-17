flush tables;
set profiling=1;
select count(1) into @rows from loglines where logline regexp '^66\.249\.65\.20';
set profiling=0;
select query_id,'bolanchor' as "Query",@rows as "Row Count", ceiling(sum(duration * 1000)) as msecs from information_schema.profiling group by query_id;
