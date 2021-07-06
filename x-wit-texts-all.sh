#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace # uncomment for debugging

grep -o "wit=\"[^\"]*\"" "${1}" | sed -e "s_\([\"#]\|wit=\|ceteri\)__g" -e "s_ _\n_g" | sed "/^ *$/d" | sort | uniq | \
    while read w;
    do
	echo "Extracting witness ${w}"
	xsltproc --output wit_texts/"hp1-20_${w}".xml --stringparam wit_id "${w}" x-wit-text.xsl "${1}"
    done
