#!/bin/bash

####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################

#conda activate cutadaptenv
file="/home/asela/Methylation/20200909_methylation/01_Preproprocessing/20200909_filenames.txt"

PROJECT_DIR=/home/asela/Methylation/20200909_methylation





#mkdir $ALIGN

QTRIM_DATA=${PROJECT_DIR}/01_Preproprocessing


ADP_REM=$QTRIM_DATA/Adapter_Removed

ADP_REM_BB=$QTRIM_DATA/BB_Adapter_Removed


ALIGN=$PROJECT_DIR/02_alignment

METH_RATE=$PROJECT_DIR/04_algin_ecoli



###################################SOFTWARE SETTINGS##################################################################
###Q_TRIM AND ADAPTER REMOVING#####

Genome_path=/home/asela/genome/Ecoli

while IFS=" " read -r value1 value2

do {


###################################File downloads#####################################################################

FIRST_SAMPLE_LOC=$ADP_REM_BB/${value1}_bb_trim_R1.fastq
SECCOND_SAMPLE_LOC=$ADP_REM_BB/${value1}_bb_trim_R2.fastq


#######################################################################################################################


####################################Adapter Removing####################################################################


bismark --non_directional -p 12 $Genome_path -1 $FIRST_SAMPLE_LOC  -2 $SECCOND_SAMPLE_LOC -o $METH_RATE
  
cd $METH_RATE

deduplicate_bismark  -p 12 ${value1}_bb_trim_R1_bismark_bt2_pe.bam  -o ${value1}_ecoli_trim

cd $METH_RATE

bismark_methylation_extractor -p 12 --bedGraph --gzip ${value1}_ecoli_trim.deduplicated.bam

} done <"$file"





