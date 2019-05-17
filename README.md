# Prebuild libtorch binary for CI

Download prebuild libtorch binaries from pytorch-official-site.
Then upload them to this repo's release-page.
To do the operations, type following commands.

``
#Install github-release command
> go get github.com/aktau/github-release

#Download libtorch-binaries
> ./download-binary.sh

#Set github-token
> export GITHUB_TOKEN=xxxx

#Upload libtorch-binaries to github
> ./upload-binary.sh
``
