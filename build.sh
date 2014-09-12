#!/bin/bash

# Publish data sets to a local fuseki image
# Assumes fuseki is running and fuseki commands are on classpath

# cd build; mkdir ORG-DB; fuseki-server --loc=ORG-DB --update /ds

readonly GRAPH_BASE=http://reference.data.gov.uk/organogram/graph
readonly PERM_GRAPH=$GRAPH_BASE/perm
readonly SERVICE=http://localhost:3030/ds
readonly DEFAULT=2013-09-30

function put {
    local period="$1"
    local filebase="${period}/merge-${period}-vocab.nt"
    echo " * s-put $SERVICE/data $GRAPH_BASE/$period $filebase"
    gunzip "${filebase}.gz"
    s-put $SERVICE/data $GRAPH_BASE/$period $filebase
    gzip "${filebase}"
}

function putdefault {
    local period="$1"
    local filebase="${period}/merge-${period}-vocab.nt"
    echo " * s-put $SERVICE/data default $filebase"
    gunzip "${filebase}.gz"
    s-put $SERVICE/data default $filebase
    gzip "${filebase}"
}

function putall {
    local basegraph="$1"
    local basedir="$2"

    local f
    for f in $basedir/*.ttl
    do
        if [[ "$f" =~ .*/([^/\*]*\.ttl) ]] ;
        then
            local fname="${BASH_REMATCH[1]}"
            echo " * Loading $fname"
            s-put $SERVICE/data "$basegraph/$fname" "$basedir/$fname"
        fi
    done
}

for i in 20*; 
do
    echo "** Loading $i merged data"
    put $i    
    
    echo "** Loading $i individual data, if available"
    putall "$GRAPH_BASE/$i" "$i/rdf"
done

echo "** Loading default graph"
putdefault $DEFAULT

echo "** Loading vocabularies"
putall $PERM_GRAPH vocabs
