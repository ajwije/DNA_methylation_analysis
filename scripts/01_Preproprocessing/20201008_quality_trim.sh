#!/bin/bash

####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################
file="/home/labcomputer/Documents/Asela/20200909_methylation/00_Quality_assesment/20200909_filenames.txt"


PROJECT_SAMPLE_DIR=/home/labcomputer/Documents/Asela/20200909_methylation

RAW_DATA=raw_data
QUALITY=01_Quality_assesment

QTRIM_DATA=${PROJECT_SAMPLE_DIR}/${QUALITY}/PREPROCESSING
mkdir -p $QTRIM_DATA
mkdir $QTRIM_DATA/FASTQC
mkdir $QTRIM_DATA/FASTQC/Before_Q_Trim

ADP_REM=$QTRIM_DATA/Adapter_Removed
mkdir $ADP_REM

A_Q_T=$QTRIM_DATA/FASTQC/FASTQ_After_Q_Trim
mkdir $A_Q_T

###################################SOFTWARE SETTINGS##################################################################
###Q_TRIM AND ADAPTER REMOVING#####
FASTQ_TYPE="sanger"
QUALIY_THRESHOLD=20
MIN_LENGTH=40
ADAPTER_SEQ=AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC

U_ADAPTER_SEQ=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT

#conda activate cutadaptenv

#######################################################################################################################
while IFS=" " read -r value1 value2

do {


###################################File downloads#####################################################################

FIRST_SAMPLE_LOC=${PROJECT_SAMPLE_DIR}/${RAW_DATA}/${value1}/${value2}-1a_HC7TNCCX2_L1_1.fq.gz
SECCOND_SAMPLE_LOC=${PROJECT_SAMPLE_DIR}/${RAW_DATA}/${value1}/${value2}-1a_HC7TNCCX2_L1_2.fq.gz


####################################Fastqc#############################################################################

#cd $QTRIM_DATA/FASTQC/Before_Q_Trim/

#fastqc $FIRST_SAMPLE_LOC $SECCOND_SAMPLE_LOC -o $PWD

####################################Adapter Removing####################################################################

cd $ADP_REM

cutadapt -q $QUALIY_THRESHOLD --length 100 --cores=12 -m $MIN_LENGTH -a $ADAPTER_SEQ -A $ADAPTER_SEQ -o ${value1}_trim_R1.fastq -p ${value1}_trim_R2.fastq $FIRST_SAMPLE_LOC $SECCOND_SAMPLE_LOC


####################################Fastqcaftertrimming#############################################################################

#cd ${PROJECT_SAMPLE_DIR}/${QUALITY}

#fastqc $FIRST_SAMPLE_LOC $SECCOND_SAMPLE_LOC -o $PWD


} done <"$file"

#conda deactivate

