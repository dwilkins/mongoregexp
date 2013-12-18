var msie_count = db.loglines.find( { logline: /MSIE [0-9]{1,}[\.0-9]{0,}/i ,$comment: "03-msiecount"}).count();
print("03-msiecount=" + msie_count);