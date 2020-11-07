VERSION=1.7.0

FILES=libtorch_$(VERSION)+cpu-1_amd64.deb \
    libtorch_$(VERSION)+cu92-1_amd64.deb \
    libtorch_$(VERSION)+cu101-1_amd64.deb \
    libtorch_$(VERSION)+cu102-1_amd64.deb \
    libtorch_$(VERSION)+cu110-1_amd64.deb \
    libtorch-$(VERSION)+cpu-1.x86_64.rpm \
    libtorch-$(VERSION)+cu92-1.x86_64.rpm \
    libtorch-$(VERSION)+cu101-1.x86_64.rpm \
    libtorch-$(VERSION)+cu102-1.x86_64.rpm \
    libtorch-$(VERSION)+cu110-1.x86_64.rpm \
    cpu-libtorch-macos-latest.zip \
    cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip \
    cu92-libtorch-cxx11-abi-shared-with-deps-latest.zip \
    cu101-libtorch-cxx11-abi-shared-with-deps-latest.zip \
    cu102-libtorch-cxx11-abi-shared-with-deps-latest.zip \
    cu110-libtorch-cxx11-abi-shared-with-deps-latest.zip

all:$(FILES)

upload:$(FILES)
	github-release release -u hasktorch -r libtorch-binary-for-ci -t $(VERSION)
	for i in $(FILES) ; do echo $$i ;github-release upload -u hasktorch -r libtorch-binary-for-ci -t $(VERSION) -R -n $$i -f $$i ; done

cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cpu.zip
	ln -s $< $@ 

cu92-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu92.zip
	ln -s $< $@ 

cu101-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu101.zip
	ln -s $< $@ 

cu102-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION).zip
	ln -s $< $@ 

cpu-libtorch-macos-latest.zip: libtorch-macos-$(VERSION).zip
	ln -s $< $@

libtorch-macos-1.6.0.zip:
	wget -c https://download.pytorch.org/libtorch/cpu/libtorch-macos-1.6.0.zip

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

libtorch-$(VERSION)+cu92.tgz:libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu92.zip
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

libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu101.zip:
	wget -c https://download.pytorch.org/libtorch/cu101/libtorch-cxx11-abi-shared-with-deps-$(VERSION)%2Bcu101.zip

libtorch-$(VERSION)+cu101.tgz:libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu101.zip
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


libtorch-cxx11-abi-shared-with-deps-$(VERSION).zip:
	wget -c https://download.pytorch.org/libtorch/cu102/libtorch-cxx11-abi-shared-with-deps-$(VERSION).zip

libtorch-$(VERSION)+cu102.tgz:libtorch-cxx11-abi-shared-with-deps-$(VERSION).zip
	rm -rf libtorch usr/
	unzip libtorch-cxx11-abi-shared-with-deps-$(VERSION).zip
	mkdir -p usr/
	cp -r libtorch/* usr/
	cd usr/include/torch; for i in csrc/api/include/torch/* ; do ln -s $$i ;done
	tar cvfz libtorch-$(VERSION)+cu102.tgz usr

libtorch_$(VERSION)+cu102-1_amd64.deb:libtorch-$(VERSION)+cu102.tgz
	fakeroot alien --to-deb --bump=0 --version=$(VERSION)+cu102 --target=amd64 libtorch-$(VERSION)+cu102.tgz

libtorch-$(VERSION)+cu102-1.x86_64.rpm:libtorch-$(VERSION)+cu102.tgz
	fakeroot alien --to-rpm --bump=0 --version=$(VERSION)+cu102 --target=amd64 libtorch-$(VERSION)+cu102.tgz

libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu110.zip:
	wget -c https://download.pytorch.org/libtorch/cu110/libtorch-cxx11-abi-shared-with-deps-$(VERSION)%2Bcu110.zip

libtorch-$(VERSION)+cu110.tgz:libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu110.zip
	rm -rf libtorch usr/
	unzip libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu110.zip
	mkdir -p usr/
	cp -r libtorch/* usr/
	cd usr/include/torch; for i in csrc/api/include/torch/* ; do ln -s $$i ;done
	tar cvfz libtorch-$(VERSION)+cu110.tgz usr

libtorch_$(VERSION)+cu110-1_amd64.deb:libtorch-$(VERSION)+cu110.tgz
	fakeroot alien --to-deb --bump=0 --version=$(VERSION)+cu110 --target=amd64 libtorch-$(VERSION)+cu110.tgz

libtorch-$(VERSION)+cu110-1.x86_64.rpm:libtorch-$(VERSION)+cu110.tgz
	fakeroot alien --to-rpm --bump=0 --version=$(VERSION)+cu110 --target=amd64 libtorch-$(VERSION)+cu110.tgz


