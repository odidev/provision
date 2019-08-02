#!/bin/bash

# This is used to build the cli docs.  Need to convert md to rst.
# Run this after tools/build.sh

# This requires pandoc and sphinx tools installed.

rm -rf doc/cli
mkdir -p doc/cli
./drpcli-docs

cd doc/cli

for i in `ls *.md`
do
        FILE=`basename $i .md`
        grep -v "Auto generated by" $FILE.md > $FILE-input.md
        pandoc --from=markdown --to=rst --output=$FILE.rst $FILE-input.md
        rm $FILE.md $FILE-input.md
done

cd ../..

rm -rf _build ; make html

