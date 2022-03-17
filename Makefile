PREVIOUS_VERSION=1.9.0
VERSION=1.11.0

FILES=libtorch_$(VERSION)+cpu-1_amd64.deb \
    libtorch_$(VERSION)+cu102-1_amd64.deb \
    libtorch_$(VERSION)+cu113-1_amd64.deb \
    cpu-libtorch-macos-latest.zip \
    cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip \
    cu102-libtorch-cxx11-abi-shared-with-deps-latest.zip \
    cu113-libtorch-cxx11-abi-shared-with-deps-latest.zip

all:$(FILES)

upload:$(FILES)
	gh release create -t $(VERSION) -n "" $(VERSION)
	for i in $(FILES) ; do echo $$i ; gh release upload $(VERSION) $$i ; done

cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cpu.zip
	ln -s $< $@ 

cu102-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu102.zip
	ln -s $< $@ 

cu113-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu113.zip
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

libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu113.zip:
	wget -c https://download.pytorch.org/libtorch/cu113/libtorch-cxx11-abi-shared-with-deps-$(VERSION)%2Bcu113.zip

libtorch-$(VERSION)+cu113.tgz:libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu113.zip
	rm -rf libtorch usr/
	unzip libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cu113.zip
	mkdir -p usr/
	cp -r libtorch/* usr/
	cd usr/include/torch; for i in csrc/api/include/torch/* ; do ln -s $$i ;done
	tar cvfz libtorch-$(VERSION)+cu113.tgz usr

libtorch_$(VERSION)+cu113-1_amd64.deb:libtorch-$(VERSION)+cu113.tgz
	fakeroot alien --to-deb --bump=0 --version=$(VERSION)+cu113 --target=amd64 libtorch-$(VERSION)+cu113.tgz

libtorch-$(VERSION)+cu113-1.x86_64.rpm:libtorch-$(VERSION)+cu113.tgz
	fakeroot alien --to-rpm --bump=0 --version=$(VERSION)+cu113 --target=amd64 libtorch-$(VERSION)+cu113.tgz


update-apt:
	wget https://github.com/hasktorch/libtorch-binary-for-ci/releases/download/apt/Packages_$(PREVIOUS_VERSION).gz
	zcat Packages_$(PREVIOUS_VERSION).gz > Packages.org
	apt-ftparchive packages ./ > Packages.new
	cat Packages.new Packages.org | gzip | dd of=Packages.gz bs=1M
	for i in *.deb ; do echo $$i ; gh release upload apt $$i ; done
	cp Packages.gz Packages_$(VERSION).gz
	gh release upload apt Packages.gz --clobber
	gh release upload apt Packages_$(VERSION).gz
