#!/bin/bash
# Processes all the original CSVs for this data set to corresponding ttl files, then builds the merge
# Assumes there is a logcal org-dc instance running on :8080

for i in csv/*-senior.csv ;
do
    echo "Processing $i"
    if [[ $i =~ csv/(.*)-senior.csv ]]
    then
        f=${BASH_REMATCH[1]}
        curl -s -F "release=2013-09-30" -F "senior-csv=@csv/$f-senior.csv" -F "junior-csv=@csv/$f-junior.csv" http://localhost:8080/convert > rdf/$f.ttl
    fi
done

echo "Merging ..."
rdfcat -out N-TRIPLE rdf/*.ttl | gzip -c > merge-2013-09-30.nt.gz
