#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace # uncomment for debugging

[ -z "${1:-}" ] && echo "Please provide an array of files as argument 1, like 'wit_texts/HP2*'" && exit 1

for x in wit_texts/HP2.1-5_edition-tei_*
do
    xsltproc xml-to-fasta.xsl "$(realpath $x)"
done

exit 0
