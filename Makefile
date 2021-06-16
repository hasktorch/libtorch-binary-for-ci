VERSION=1.9.0

FILES=cpu-libtorch-macos-latest.zip

_FILES=libtorch_$(VERSION)+cpu-1_amd64.deb \
    libtorch_$(VERSION)+cu102-1_amd64.deb \
    libtorch_$(VERSION)+cu111-1_amd64.deb \
    libtorch-$(VERSION)+cpu-1.x86_64.rpm \
    libtorch-$(VERSION)+cu102-1.x86_64.rpm \
    libtorch-$(VERSION)+cu111-1.x86_64.rpm \
    cpu-libtorch-macos-latest.zip \
    cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip \
    cu102-libtorch-cxx11-abi-shared-with-deps-latest.zip \
    cu111-libtorch-cxx11-abi-shared-with-deps-latest.zip

all:$(FILES)

upload:$(FILES)
	gh release create -t $(VERSION) -n "" $(VERSION)
	for i in $(FILES) ; do echo $$i ; gh release upload $(VERSION) $$i ; done

cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cpu.zip
	ln -s $< $@ 

cu102-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu102.zip
	ln -s $< $@ 

cu111-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu111.zip
	ln -s $< $@ 

cpu-libtorch-macos-latest.zip: libtorch-macos-$(VERSION).zip
	ln -s $< $@

libtorch-macos-$(VERSION).zip:
	wget -c https://download.pytorch.org/libtorch/cpu/libtorch-macos-$(VERSION).zip

libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cpu.zip:
	wget -c https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-$(VERSION)%2Bcpu.zip

libtorch-$(VERSION)+cpu.tgz:libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cpu.zip
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

libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu92.zip:
	wget -c https://download.pytorch.org/libtorch/cu92/libtorch-cxx11-abi-shared-with-deps-$(VERSION)%2Bcu92.zip

libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu102.zip:
	wget -c https://download.pytorch.org/libtorch/cu102/libtorch-cxx11-abi-shared-with-deps-$(VERSION)%2Bcu102.zip

libtorch-$(VERSION)+cu102.tgz:libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu102.zip
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

libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu111.zip:
	wget -c https://download.pytorch.org/libtorch/cu111/libtorch-cxx11-abi-shared-with-deps-$(VERSION)%2Bcu111.zip

libtorch-$(VERSION)+cu111.tgz:libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu111.zip
	rm -rf libtorch usr/
	unzip libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu111.zip
	mkdir -p usr/
	cp -r libtorch/* usr/
	cd usr/include/torch; for i in csrc/api/include/torch/* ; do ln -s $$i ;done
	tar cvfz libtorch-$(VERSION)+cu111.tgz usr

libtorch_$(VERSION)+cu111-1_amd64.deb:libtorch-$(VERSION)+cu111.tgz
	fakeroot alien --to-deb --bump=0 --version=$(VERSION)+cu111 --target=amd64 libtorch-$(VERSION)+cu111.tgz

libtorch-$(VERSION)+cu111-1.x86_64.rpm:libtorch-$(VERSION)+cu111.tgz
	fakeroot alien --to-rpm --bump=0 --version=$(VERSION)+cu111 --target=amd64 libtorch-$(VERSION)+cu111.tgz


