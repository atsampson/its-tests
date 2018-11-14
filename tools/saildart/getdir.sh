#!/bin/sh -ex
# e.g. get.sh '[*,DEK]'

cd www.saildart.org

curl="curl -v -g --compressed"

for dir in "$@"; do

	# XXX  are there dirs with more than one toc?.html?

	dirfn="$dir/toc1.html"
	if [ ! -f "$dirfn" ]; then
		$curl --create-dirs -o "$dirfn" 'https://www.saildart.org/'"$dir"'/toc1.html'
	fi

	cat "$dirfn" | \
		perl -ne 'if (/^<li>.*href="\/([^"]+)"/ && !-e "$1_octal") { print "https://www.saildart.org/$1_octal\n"; }' | \
		grep -v '[0-9]_octal' | \
		xargs -r $curl --remote-name-all

done
