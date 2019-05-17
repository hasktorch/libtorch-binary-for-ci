#!/usr/bin/env bash
VERSION=`cat libtorch/build-version`
for i in *.zip  ; do
		echo $i;
		github-release upload -u hasktorch -r libtorch-binary-for-ci -t $VERSION -R -n $i -f $i ;
done
