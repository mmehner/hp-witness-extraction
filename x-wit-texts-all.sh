#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace # uncomment for debugging

date="$(date +%Y-%m-%d)"

[ ! -f "${1}" ] && echo "${1} not a file." && exit 1    

grep -o "wit=\"[^\"]*\"" "${1}" | sed -e "s_\([\"#]\|wit=\|ceteri\)__g" -e "s_ _\n_g" | sed "/^ *$/d" | sort | uniq | \
    while read w;
    do
	echo "Extracting witness ${w}"
	
	wit_text="wit_texts/${1%.xml}_${w}.xml"
	xsltproc --output "${wit_text}" --stringparam wit_id "${w}" --stringparam date "${date}" x-wit-text.xsl "${1}"

	sed -i "${wit_text}" \
	    -e "s_RDG\(</s><s[^>]*>\)\?LTN._\1_g" \
	    -e "s_RDG\|LTN__g"
	
    done
