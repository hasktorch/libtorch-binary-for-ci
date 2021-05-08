# Prebuild libtorch binary for CI

Download prebuild libtorch binaries from pytorch-official-site.
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
