#!/bin/bash
# Create a merged ntriplle dump of the vocabular files
# and merge that into the merges of each time period

rdfcat -out N-TRIPLE vocabs/*.ttl > vocab-merge.nt

for i in 20*; 
do
    echo "Merging $i"
    merge_source=${i}/merge-${i}.nt.gz
    merge_dest=${i}/merge-${i}-vocab.nt.gz
    gunzip -c $merge_source | cat vocab-merge.nt - | gzip - > $merge_dest
done
