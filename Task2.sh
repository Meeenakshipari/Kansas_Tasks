#!/bin/bash


wget https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.faa

gzip -k NC_000913.faa

var1=$(zgrep ">" NC_000913.faa |wc -l)
#echo $var1

var2=$(zgrep -v ">" NC_000913.faa|tr -d "\n"|wc -c)
#echo $var2

echo "($var2/$var1)"|bc
