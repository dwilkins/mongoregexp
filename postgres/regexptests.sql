\c logs
\timing
select 'msiecount' as Query,count(1) from loglines where logline ~ 'MSIE [0-9]{1,}[\.0-9]{0,}';
select 'bolanchor' as Query,count(1) from loglines where logline ~ '^66\.249\.65\.20';
select 'eolanchor' as Query,count(1) from loglines where logline ~ 'baidu\.com\/search\/spider\.html\)"$';

