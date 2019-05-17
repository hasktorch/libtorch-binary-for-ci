#!/usr/bin/env bash


#USE_NIGHTLY="nightly/"
USE_NIGHTLY=""

for arch in "shared-with-deps-latest" "macos-latest" "win-shared-with-deps-latest" ; do
		for cuda in cpu cu90 cu100 ; do
				if [ $arch = "macos-latest" ] && [ $cuda = "cu90" -o $cuda = "cu100" -o $cuda = "cu80" ]; then
					 echo "skip ${cuda} of ${arch}";
				else
						wget -O ${cuda}-libtorch-${arch}.zip https://download.pytorch.org/libtorch/${USE_NIGHTLY}${cuda}/libtorch-${arch}.zip;
				fi
		done
done
unzip ./cpu-libtorch-shared-with-deps-latest.zip libtorch/build-version
unzip ./cpu-libtorch-shared-with-deps-latest.zip libtorch/build-hash
