var eol_count = db.loglines.find( { logline: /\+http:\/\/www.baidu.com\/search\/spider\.html\)"$/ ,$comment: "02-eolanchor"}).count();
print(eol_count)

