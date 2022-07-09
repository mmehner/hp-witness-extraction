#!/bin/sh

inputf="Marmasthanas.tex"
csv="marma.csv"
idx="marma_sigla.txt"
fasta="marma.fas"

echo "" > $fasta

#write structured data: csv
#set output field separator
#only operate on lines with \item-pattern
#set input field separator
#substitutions in various fields

#select & normalize
grep  "\\item\[[^]]" Marmasthanas.tex | \
    sed -e '/^\s*%/d' \
	-e 's_^\s*\\item\[\s*__' \
	-e 's___' \
	-e 's_\s\+$__' \
	-e 's_[{}]__g' \
	-e 's_ *%.*__' \
	-e 's_\s*,\s*_,_g' \
	-e 's_^(.*illeg.*)_0_' \
	-e 's_\s*([^()]\+)__g' \
	-e 's_\s*([^()]\+)__g' \
	-e 's_\s*\[.\+\]__g' \
	-e '/^,/d' \
	-e 's_\]\s*_,_' > $csv

# write sigla-index
awk 'BEGIN { FS=","; OFS="\n"} \
    { $1=""; print; }' \
    < ${csv} | sort | uniq | sed '/^\s*$/d' > $idx

# transform
while IFS= read -r sig
do
    # prüfschleife für ac/pc
    basesig=""
    [[ $sig =~ .*[ap]c$ ]] && basesig="${sig:0:-2}"
	
    printf "\n\n>%s\n" ${sig} >> ${fasta}
    
    awk -v sig="${sig}" -v basesig="${basesig}" \
	'BEGIN { ORS=" "; FS="," }
    	{
		if ( match($0,sig) ) { print $1};
		if ( basesig != "" && match($0,basesig) ) { print $1};
	}'\
	    < ${csv} \
	    >> ${fasta}
done < "$idx"
