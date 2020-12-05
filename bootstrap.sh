#!/bin/bash
set -e

tarball=/tmp/frio.tar.gz

rm -rf $tarball && wget -O $tarball https://github.com/frago-io/dev-env/tarball/main

unpackfolder=/tmp

echo "rm -rf $unpackfolder/frago-io-dev-env*"
rm -rf $unpackfolder/frago-io-dev-env*

echo "tar zxvf $tarball -C $unpackfolder"
tar zxvf $tarball -C $unpackfolder

destParent=$HOME/.local/etc/frago.io

echo "mkdir -p $destParent"
mkdir -p $destParent

dest=$destParent/dev-env
echo "rm -rf $dest"
rm -rf $dest

echo "mv $unpackfolder/frago-io-dev-env* $dest"
mv $unpackfolder/frago-io-dev-env* $dest

set +e
cd $dest
source ./install.sh
