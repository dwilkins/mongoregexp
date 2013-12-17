var profile_lines = db.system.profile.find({ "op": "command" ,"command.query.$comment": {$exists:1}})
    .sort({$natural: -1}).limit(100);
var i;
for (i = 0; i < profile_lines.length() ; i++) {
    profile_line = profile_lines[i];
    if(profile_line.command.query.logline != undefined) {
        print(profile_line.command.query.logline + " --- " + profile_line.millis + "ms -- " + profile_line.command.query.$comment);
    }
}