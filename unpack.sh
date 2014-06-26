#!/bin/bash

# Unpack raw TSO archives

for i in //server02/ProjectFiles/Organograms/tso-dumps/*
do
    if [[ $i =~ .*/([^/\*]*)\.zip ]] ;
    then
        dir=${BASH_REMATCH[1]}
        echo "Unpack $i to $dir"
        mkdir -p $dir
        cd $dir
        unzip $i
        cd ..
    fi   
done
