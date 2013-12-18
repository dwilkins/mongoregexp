var bol_count = db.loglines.find( { logline: /^66\.249\.65\.20/ ,$comment: "01-bolanchor"}).count();
print("01-bolanchor=" + bol_count);

