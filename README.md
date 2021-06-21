# Prebuilt libtorch binary for CI

Download prebuilt libtorch binaries from pytorch-official-site.
Then upload them to this repo's release-page.
To do the operations, type following commands.

```
# Install gh command (https://cli.github.com/)
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh

# Install alien and fakeroot to make deb/rpm files for linux.
sudo apt install alien fakeroot

#Download libtorch-binaries
> make

#Upload libtorch-binaries to github
> make upload
```

# APT

We provide a apt repository of libtorch for ubuntu.
You can install libtorch with the following command.

```shell
sudo bash -c "echo deb [trusted=yes] https://github.com/hasktorch/libtorch-binary-for-ci/releases/download/apt ./ > /etc/apt/sources.list.d/libtorch.list"
sudo apt update
# For CPU-only
sudo apt install libtorch=1.8.1+cpu-1
# For CUDA-10.2
sudo apt install libtorch=1.8.1+cu102-1
# For CUDA-11.1
sudo apt install libtorch=1.8.1+cu111-1
```
