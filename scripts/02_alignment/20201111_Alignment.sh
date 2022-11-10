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



###################################SOFTWARE SETTINGS##################################################################
###Q_TRIM AND ADAPTER REMOVING#####

Genome_path=/home/asela/genome/genome_V3

while IFS=" " read -r value1 value2

do {


###################################File downloads#####################################################################

FIRST_SAMPLE_LOC=$ADP_REM_BB/${value1}_bb_trim_R1.fastq
SECCOND_SAMPLE_LOC=$ADP_REM_BB/${value1}_bb_trim_R2.fastq


#######################################################################################################################


####################################Adapter Removing####################################################################


#bismark --non_directional $Genome_path -1 $FIRST_SAMPLE_LOC \
#  -2 $SECCOND_SAMPLE_LOC -o $ALIGN
  
cd $ALIGN 

deduplicate_bismark  -p ${value1}_bb_trim_R1_bismark_bt2_pe.bam  -o ${value1}_bb_trim

cd $ALIGN

bismark_methylation_extractor --bedGraph --gzip ${value1}_bb_trim.deduplicated.bam

} done <"$file"



