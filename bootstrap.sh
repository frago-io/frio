#!/bin/bash
set -e


tarball=/tmp/frio.tar.gz

rm -rf $tarball && wget -O $tarball https://github.com/frago-io/frio/tarball/main

unpackfolder=/tmp

echo "rm -rf $unpackfolder/frago-io-frio*"
rm -rf $unpackfolder/frago-io-frio*

echo "tar zxvf $tarball -C $unpackfolder"
tar zxvf $tarball -C $unpackfolder

destParent=$HOME/.local/etc

echo "mkdir -p $destParent"
mkdir -p $destParent

dest=$destParent/frio
echo "rm -rf $dest"
rm -rf $dest

echo "mv $unpackfolder/frago-io-frio* $dest"
mv $unpackfolder/frago-io-frio* $dest

set +e
cd $dest
source ./install.sh
