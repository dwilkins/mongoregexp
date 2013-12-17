flush tables;
set profiling=1;
select count(1) from loglines where logline regexp '\\+http:\/\/www.baidu.com\/search\/spider\.html\)"$';
set profiling=0;
select query_id,'eolanchor' as "Query",@rows as "Row Count", ceiling(sum(duration * 1000)) as msecs from information_schema.profiling group by query_id;
