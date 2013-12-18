echo '##### Disable profiling'
mongo logs --quiet --eval "db.setProfilingLevel(0)"
echo '##### Clear profiling data'
mongo logs --quiet --eval "db.system.profile.drop()"
echo '##### Enable profiling'
mongo logs --quiet --eval "db.setProfilingLevel(2)"
echo '##### Beginning of Line Anchor test'
mongo --quiet logs mongodb/bolanchor.js
echo '##### Count MSIE browsers'
mongo --quiet logs mongodb/msiecount.js
echo '##### End of Line Anchor Test'
mongo --quiet logs mongodb/eolanchor.js
echo '##### Dump timing'
mongo --quiet logs mongodb/profile.js
