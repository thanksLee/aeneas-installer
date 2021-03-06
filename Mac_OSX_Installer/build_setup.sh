#!/bin/bash

export PATH=/usr/local/bin:/usr/local/sbin:/usr/libexec/git-core/:$PATH

CURDIR=`dirname $0`
cd $CURDIR

./install_homebrew.sh
brew tap danielbair/tap
echo Running brew update
brew update
brew install danielbair/tap/brew-pkg
brew install gettext

mkdir -p $HOME/Library/Python/2.7/lib/python/site-packages
touch $HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth
if [ ! -n "$(grep '/usr/local/lib/python2.7/site-packages' $HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth)" ]; then
	echo 'import sys; sys.path.insert(1, "/usr/local/lib/python2.7/site-packages")' >> $HOME/Library/Python/2.7/lib/python/site-packages/homebrew.pth
fi

if [ ! -f "/usr/local/bin/packagesbuild" ]; then
	brew cask install packages
fi

echo -e "\n\nNow run build_packages.sh\n\n"
