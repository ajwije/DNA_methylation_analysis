#!/bin/bash

####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################
file="/home/asela/Methylation/20200909_methylation/01_Preproprocessing/20200909_filenames.txt"


PROJECT_SAMPLE_DIR=/home/asela/Methylation/20200909_methylation

RAW_DATA=/home/share/ngsProjectWithASU/X202SC20080396-Z01-F002/raw_data


QTRIM_DATA=${PROJECT_SAMPLE_DIR}/01_Preproprocessing
#mkdir -p $QTRIM_DATA
mkdir $QTRIM_DATA/FASTQC
mkdir $QTRIM_DATA/FASTQC/Before_Q_Trim

ADP_REM=$QTRIM_DATA/Adapter_Removed

ADP_REM_BB=$QTRIM_DATA/BB_Adapter_Removed

mkdir $ADP_REM
mkdir $ADP_REM_BB

A_Q_T=$QTRIM_DATA/FASTQC/FASTQ_After_BBQ_Trim
mkdir $A_Q_T

###################################SOFTWARE SETTINGS##################################################################
###Q_TRIM AND ADAPTER REMOVING#####
FASTQ_TYPE="sanger"
#minmum quality score
QUALIY_THRESHOLD=20
#This is the minimum read length after trimming. 
MIN_LENGTH=50
#reads will be trimmed to 100bp
#TRIM_LENTH=100
ADAPTER_SEQ=AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC

U_ADAPTER_SEQ=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT

#conda activate cutadaptenv

#######################################################################################################################
while IFS=" " read -r value1 value2

do {


###################################File downloads#####################################################################

FIRST_SAMPLE_LOC=${RAW_DATA}/${value1}/${value2}-1a_HC7TNCCX2_L1_1.fq.gz
SECCOND_SAMPLE_LOC=${RAW_DATA}/${value1}/${value2}-1a_HC7TNCCX2_L1_2.fq.gz


####################################Fastqc#############################################################################

#cd $QTRIM_DATA/FASTQC/Before_Q_Trim/

#fastqc $FIRST_SAMPLE_LOC $SECCOND_SAMPLE_LOC -o $PWD

####################################Adapter Removing####################################################################

cd $ADP_REM

cutadapt -q $QUALIY_THRESHOLD --cores=10 -m $MIN_LENGTH -a $ADAPTER_SEQ -A $ADAPTER_SEQ -o ${value1}_trim_R1.fastq -p ${value1}_trim_R2.fastq $FIRST_SAMPLE_LOC $SECCOND_SAMPLE_LOC

cd $ADP_REM_BB

~/custom_scripts/bbmap/bbduk.sh -Xmx1g in1=$ADP_REM/${value1}_trim_R1.fastq in2=$ADP_REM/${value1}_trim_R2.fastq out1=${value1}_bb_trim_R1.fastq out2=${value1}_bb_trim_R2.fastq  \
 ref=~/custom_scripts/bbmap/resources/adapters.fa ktrim=r k=23 mink=11 hdist=1 tpe tbo qtrim=l trimq=$QUALIY_THRESHOLD

####################################Fastqcaftertrimming#############################################################################

cd $A_Q_T

fastqc $ADP_REM_BB/${value1}_bb_trim_R1.fastq $ADP_REM_BB/${value1}_bb_trim_R2.fastq -o $PWD


} done <"$file"

#conda deactivate

