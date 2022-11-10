#!/bin/bash

####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################

#conda activate cutadaptenv
file="/home/asela/Methylation/20200909_methylation/01_Preproprocessing/20200909_filenames_2.txt"

PROJECT_DIR=/home/asela/Methylation/20200909_methylation





#mkdir $ALIGN

QTRIM_DATA=${PROJECT_DIR}/01_Preproprocessing


ADP_REM=$QTRIM_DATA/Adapter_Removed

ADP_REM_BB=$QTRIM_DATA/BB_Adapter_Removed


ALIGN=$PROJECT_DIR/02_alignment

METH_RATE=$PROJECT_DIR/03_bisulphite_convert_rate



###################################SOFTWARE SETTINGS##################################################################
###Q_TRIM AND ADAPTER REMOVING#####

Genome_path=/home/asela/genome/genome_V3

while IFS=" " read -r value1 value2

do {




#######################################################################################################################



cd $METH_RATE



bismark_methylation_extractor --comprehensive --merge_non_CpG --bedGraph --CX --cytosine_report --CX \
--genome_folder /home/asela/genome/Ecoli $ALIGN/${value1}_bb_trim.deduplicated.bam

cd $METH_RATE

intersectBed -v -a ${value1}_bb_trim.deduplicated.bedGraph.gz -b ${value1}_ecoli_unmC.bed | awk '{methperc+=$4; allC++} END {print 100-methperc/allC}'


} done <"$file"



