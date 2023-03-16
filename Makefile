TOKENIZERS_VERSION=0.1
PREVIOUS_VERSION=1.11.0
VERSION=2.0.0
CUDA0=cu117
CUDA1=cu118

FILES=libtorch_$(VERSION)+cpu-1_amd64.deb \
    libtorch_$(VERSION)+$(CUDA0)-1_amd64.deb \
    libtorch_$(VERSION)+$(CUDA1)-1_amd64.deb \
    libtokenizers_$(TOKENIZERS_VERSION)-1_amd64.deb \
    cpu-libtorch-macos-latest.zip \
    cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip \
    $(CUDA0)-libtorch-cxx11-abi-shared-with-deps-latest.zip \
    $(CUDA1)-libtorch-cxx11-abi-shared-with-deps-latest.zip

all:$(FILES)

upload:$(FILES)
	gh release create -t $(VERSION) -n "" $(VERSION)
	for i in $(FILES) ; do echo $$i ; gh release upload $(VERSION) $$i ; done

cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+cpu.zip
	ln -s $< $@ 

$(CUDA0)-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+$(CUDA0).zip
	ln -s $< $@ 

$(CUDA1)-libtorch-cxx11-abi-shared-with-deps-latest.zip: libtorch-cxx11-abi-shared-with-deps-$(VERSION)+$(CUDA1).zip
	ln -s $< $@ 

cpu-libtorch-macos-latest.zip: libtorch-macos-$(VERSION).zip
	ln -s $< $@

libtokenizers-linux.zip:
	wget https://github.com/hasktorch/tokenizers/releases/download/libtokenizers-v$(TOKENIZERS_VERSION)/libtokenizers-linux.zip

libtokenizers_$(TOKENIZERS_VERSION)-1_amd64.deb:libtokenizers-linux.zip
	rm -rf libtokenizers usr/
	unzip libtokenizers-linux.zip
	mkdir -p usr/
	cp -r libtokenizers/* usr/
	tar cvfz libtokenizers-$(TOKENIZERS_VERSION).tgz usr
	fakeroot alien --to-deb --bump=0 --version=$(TOKENIZERS_VERSION) --target=amd64 libtokenizers-$(TOKENIZERS_VERSION).tgz

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

libtorch-cxx11-abi-shared-with-deps-$(VERSION)+$(CUDA0).zip:
	wget -c https://download.pytorch.org/libtorch/$(CUDA0)/libtorch-cxx11-abi-shared-with-deps-$(VERSION)%2B$(CUDA0).zip

libtorch-$(VERSION)+$(CUDA0).tgz:libtorch-cxx11-abi-shared-with-deps-$(VERSION)+$(CUDA0).zip
	rm -rf libtorch usr/
	unzip libtorch-cxx11-abi-shared-with-deps-$(VERSION)+$(CUDA0).zip
	mkdir -p usr/
	cp -r libtorch/* usr/
	cd usr/include/torch; for i in csrc/api/include/torch/* ; do ln -s $$i ;done
	tar cvfz libtorch-$(VERSION)+$(CUDA0).tgz usr

libtorch_$(VERSION)+$(CUDA0)-1_amd64.deb:libtorch-$(VERSION)+$(CUDA0).tgz
	fakeroot alien --to-deb --bump=0 --version=$(VERSION)+$(CUDA0) --target=amd64 libtorch-$(VERSION)+$(CUDA0).tgz

libtorch-$(VERSION)+$(CUDA0)-1.x86_64.rpm:libtorch-$(VERSION)+$(CUDA0).tgz
	fakeroot alien --to-rpm --bump=0 --version=$(VERSION)+$(CUDA0) --target=amd64 libtorch-$(VERSION)+$(CUDA0).tgz

libtorch-cxx11-abi-shared-with-deps-$(VERSION)+$(CUDA1).zip:
	wget -c https://download.pytorch.org/libtorch/$(CUDA1)/libtorch-cxx11-abi-shared-with-deps-$(VERSION)%2B$(CUDA1).zip

libtorch-$(VERSION)+$(CUDA1).tgz:libtorch-cxx11-abi-shared-with-deps-$(VERSION)+$(CUDA1).zip
	rm -rf libtorch usr/
	unzip libtorch-cxx11-abi-shared-with-deps-$(VERSION)+$(CUDA1).zip
	mkdir -p usr/
	cp -r libtorch/* usr/
	cd usr/include/torch; for i in csrc/api/include/torch/* ; do ln -s $$i ;done
	tar cvfz libtorch-$(VERSION)+$(CUDA1).tgz usr

libtorch_$(VERSION)+$(CUDA1)-1_amd64.deb:libtorch-$(VERSION)+$(CUDA1).tgz
	fakeroot alien --to-deb --bump=0 --version=$(VERSION)+$(CUDA1) --target=amd64 libtorch-$(VERSION)+$(CUDA1).tgz

libtorch-$(VERSION)+$(CUDA1)-1.x86_64.rpm:libtorch-$(VERSION)+$(CUDA1).tgz
	fakeroot alien --to-rpm --bump=0 --version=$(VERSION)+$(CUDA1) --target=amd64 libtorch-$(VERSION)+$(CUDA1).tgz


update-apt:
	wget https://github.com/hasktorch/libtorch-binary-for-ci/releases/download/apt/Packages_$(PREVIOUS_VERSION).gz
	zcat Packages_$(PREVIOUS_VERSION).gz > Packages.org
	apt-ftparchive packages ./ > Packages.new
	cat Packages.new Packages.org | gzip | dd of=Packages.gz bs=1M
	for i in *.deb ; do echo $$i ; gh release upload apt $$i ; done
	cp Packages.gz Packages_$(VERSION).gz
	gh release upload apt Packages.gz --clobber
	gh release upload apt Packages_$(VERSION).gz
