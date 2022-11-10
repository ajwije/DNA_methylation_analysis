# Title: Bisulphite conversation
 
## Date: 05/28/2020

## Computername and path of working directory

- laptop: ```/Documents/Projects/Methylation/200520_W82-Rpsk1/03_bisulphite_convert_rate```

- lab computer: ```/Documents/Asela/data/20_DAPseq_data/W82-Rpsk1/03_bisulphite_convert_rate```


## Description of what you are trying to do and why

Trying to calculate the bisulphite conversion rate. Use the chloroplast genome downloaded from NCBI:

```https://www.ncbi.nlm.nih.gov/nuccore/NC_007942.1?report=fasta```



Code block of the commands you used

### indexing the chloroplast genome

```bismark_genome_preparation --verbose ~/Documents/Asela/data/20_DAPseq_data/W82-Rpsk1/03_bisulphite_convert_rate/chlorplast_genome ```


```
bismark_methylation_extractor --comprehensive --merge_non_CpG --bedGraph --CX --cytosine_report --CX \
--genome_folder /home/asela/genome/Ecoli ~/Methylation/20200909_methylation/02_alignment/K1_bb_trim.deduplicated.bam

```

```
intersectBed -v -a W82-Rpsk1_combine.deduplicated.bedGraph.gz -b chloroplast_unmC.bed | awk '{methperc+=$4; allC++} END {print 100-methperc/allC}'

```

Description of the result
