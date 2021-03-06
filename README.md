Data and scripts for creating a boostrap database

## Data

Each 20xx directory except for 2013-09-30 contain the original data from TSO plus a merged ntriples file.

For 2013-09-30 this has been replaced by a merge generated by reprocessing the source CSVs through the org-dc converter, so as the check the converter. This is done in the reprocessed-2013-09-30 directory via `process.sh`.

## Vocabulary merge

The raw merges contain sporadic and partial labels but not the full vocabulary files.

The script `vocab-merge.sh` creates a merge of the vocabularies and injects it into the per-period merges.

This needs to have been run prior to the build.

## Rebuild

Start fuseki in one shell:

    mkdir build; cd build
    rm -rf ORG-DB; mkdir ORG-DB
    fuseki-server --loc=ORG-DB --update  --mgtPort=3131 /ds

The data in 2013-09-30 was generated by the process.sh script in reprocessed-2013-09-30
In another shell run the build script

    ./build.sh

If desired do a dump of the constructed TDB image (`org-backup`) and then use `tdbloader` to do a clean reload of that dump.
