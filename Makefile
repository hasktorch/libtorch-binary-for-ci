VERSION=1.5.0

all:libtorch_$(VERSION)+cpu-1_amd64.deb \
    libtorch_$(VERSION)+cu92-1_amd64.deb \
    libtorch_$(VERSION)+cu101-1_amd64.deb \
    libtorch_$(VERSION)+cu102-1_amd64.deb \
    libtorch-$(VERSION)+cpu-1.x86_64.rpm \
    libtorch-$(VERSION)+cu92-1.x86_64.rpm \
    libtorch-$(VERSION)+cu101-1.x86_64.rpm \
    libtorch-$(VERSION)+cu102-1.x86_64.rpm

libtorch-$(VERSION)+cpu.tgz:
	wget -c https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-$(VERSION)%2Bcpu.zip
	rm -rf libtorch usr/
	unzip libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cpu.zip
	mkdir -p usr
	cp -r libtorch/* usr/
	cd usr/include/torch; for i in csrc/api/include/torch/* ; do ln -s $$i ;done
	tar cvfz libtorch-$(VERSION)+cpu.tgz usr

libtorch_$(VERSION)+cpu-1_amd64.deb:libtorch-$(VERSION)+cpu.tgz
	fakeroot alien --to-deb --bump=0 --version=$(VERSION)+cpu --target=amd64 libtorch-$(VERSION)+cpu.tgz

libtorch-$(VERSION)+cpu-1.x86_64.rpm:libtorch-$(VERSION)+cpu.tgz
	fakeroot alien --to-rpm --bump=0 --version=$(VERSION)+cpu --target=amd64 libtorch-$(VERSION)+cpu.tgz


libtorch-$(VERSION)+cu92.tgz:
	rm -rf libtorch usr/
	wget -c https://download.pytorch.org/libtorch/cu92/libtorch-cxx11-abi-shared-with-deps-$(VERSION)%2Bcu92.zip
	rm -rf libtorch usr/
	unzip libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu92.zip
	mkdir -p usr
	cp -r libtorch/* usr/
	cd usr/include/torch; for i in csrc/api/include/torch/* ; do ln -s $$i ;done
	tar cvfz libtorch-$(VERSION)+cu92.tgz usr

libtorch_$(VERSION)+cu92-1_amd64.deb:libtorch-$(VERSION)+cu92.tgz
	fakeroot alien --to-deb --bump=0 --version=$(VERSION)+cu92 --target=amd64 libtorch-$(VERSION)+cu92.tgz

libtorch-$(VERSION)+cu92-1.x86_64.rpm:libtorch-$(VERSION)+cu92.tgz
	fakeroot alien --to-rpm --bump=0 --version=$(VERSION)+cu92 --target=amd64 libtorch-$(VERSION)+cu92.tgz


libtorch-$(VERSION)+cu101.tgz:
	wget -c https://download.pytorch.org/libtorch/cu101/libtorch-cxx11-abi-shared-with-deps-$(VERSION).zip
	rm -rf libtorch usr/
	unzip libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu101.zip
	mkdir -p usr/
	cp -r libtorch/* usr/
	cd usr/include/torch; for i in csrc/api/include/torch/* ; do ln -s $$i ;done
	tar cvfz libtorch-$(VERSION)+cu101.tgz usr

libtorch_$(VERSION)+cu101-1_amd64.deb:libtorch-$(VERSION)+cu101.tgz
	fakeroot alien --to-deb --bump=0 --version=$(VERSION)+cu101 --target=amd64 libtorch-$(VERSION)+cu101.tgz

libtorch-$(VERSION)+cu101-1.x86_64.rpm:libtorch-$(VERSION)+cu101.tgz
	fakeroot alien --to-rpm --bump=0 --version=$(VERSION)+cu101 --target=amd64 libtorch-$(VERSION)+cu101.tgz


libtorch-$(VERSION)+cu102.tgz:
	wget -c https://download.pytorch.org/libtorch/cu102/libtorch-cxx11-abi-shared-with-deps-$(VERSION).zip
	rm -rf libtorch usr/
	unzip libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu102.zip
	mkdir -p usr/
	cp -r libtorch/* usr/
	cd usr/include/torch; for i in csrc/api/include/torch/* ; do ln -s $$i ;done
	tar cvfz libtorch-$(VERSION)+cu102.tgz usr

libtorch_$(VERSION)+cu102-1_amd64.deb:libtorch-$(VERSION)+cu102.tgz
	fakeroot alien --to-deb --bump=0 --version=$(VERSION)+cu102 --target=amd64 libtorch-$(VERSION)+cu102.tgz

libtorch-$(VERSION)+cu102-1.x86_64.rpm:libtorch-$(VERSION)+cu102.tgz
	fakeroot alien --to-rpm --bump=0 --version=$(VERSION)+cu102 --target=amd64 libtorch-$(VERSION)+cu102.tgz

