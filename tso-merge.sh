#!/bin/bash

# Unpack raw TSO archives

# NB. Clean up hfea file names to remove ~

#for i in 2012-03-31 2012-09-30  2013-03-31  2014-03-31
for i in 2014-03-31
do
    echo "merging $i"
    rdfcat -out N-TRIPLE $i/*/*.rdf | gzip -c > $i/merge-$i.nt.gz
done
