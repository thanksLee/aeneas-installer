#!/bin/bash
IFS=$'\n'

export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH

python -m ensurepip > /dev/null

echo "Uninstalling python-numpy..."

sudo -H pip uninstall -y numpy

function pkgutil-rm {
	location=$(pkgutil --pkg-info $1 | grep "location:" | cut -d':' -f2 | sed -e "s/^[[:space:]]*//")
	volume=$(pkgutil --pkg-info $1 | grep "volume:" | cut -d':' -f2 | sed -e "s/^[[:space:]]*//")
	for file in `pkgutil --only-files --files $1`; do 
		sudo rm -v "$volume/$location/$file"; 
	done
	sudo pkgutil --forget $1
}

pkg=`pkgutil --pkgs | grep "org.python.python-numpy"`
if [[ ! -z $pkg ]]; then
	pkgutil-rm $pkg
fi
