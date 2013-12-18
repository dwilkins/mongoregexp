#!/bin/bash
echo '##### Dropping logs database'
mongo logs --quiet --eval "db.dropDatabase()"
echo '##### loading loglines into logs'
bzip2 -dc loglines.txt.bz2 | mongoimport --db logs --collection loglines --type tsv --fields logline --file -
echo '##### Creating index for loglines(logline)'
mongo logs --quiet --eval "db.loglines.ensureIndex( { logline: 1 } )"
echo '##### Disable profiling'
mongo logs --quiet --eval "db.setProfilingLevel(0)"
echo '##### Clear profiling data'
mongo logs --quiet --eval "db.system.profile.drop()"
echo '##### Enable profiling'
mongo logs --quiet --eval "db.setProfilingLevel(2)"
