# Title: preprocessing of protocols for bisulphite

## Date: 11/06/20

## Computername and path of working directory

-Mac computer: ```/Users/aselawijeratne/Documents/Projects/Methylation/20200909_methylation```

-binf-ngs server: ```~/Methylation/20200909_methylation/01_Preproprocessing```

## Description of what you are trying to do and why

-Check the quality of the data and the remove poor quality data

##Code block of the commands you used

- Use the ```FastQC v0.11.8```

- ```cutadapt 2.10 with Python 3.7.6```
- ```https://sourceforge.net/projects/bbmap/```

### use the following script for check quality of the data

- ```20201106_quality_trim.sh``` to trim quality and adapters. However, after this steps, we still find adapters left in the second reads.
- ```20201106_quality_bbtrim.sh``` use both cutadapt and bbMAP script to remove adapters. 

### Use the following script to trim sequences and check the quality of the data

##	 Description of the result

###	Multifastqc results in the

```20201111_multiqc_report.html```

Looks like still 5' end has bias nucleotides. K5 is unlikely converted sample. 





