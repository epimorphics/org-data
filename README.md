Data and scripts for creating a boostrap database

## Rebuild

Start fuseki in one shell:

    mkdir build; cd build
    rm -rf ORG-DB; mkdir ORG-DB
    fuseki-server --loc=ORG-DB --update  --mgtPort=3131 /ds

In another shell run the build script

    ./build.sh

If desired do a dump of the constructed TDB image (`org-backup`) and then use `tdbloader` to do a clean reload of that dump.

## Vocabulary merge

The raw merges contain sporadic and partial labels but not the full vocabulary files.

The script `vocab-merge.sh` creates a merge of the vocabularies and injects it into the per-period merges.

This needs to have been run prior to the build.
