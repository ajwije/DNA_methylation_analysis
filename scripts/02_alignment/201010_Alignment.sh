#!/bin/bash

####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################

#conda activate cutadaptenv
file="/home/labcomputer/Documents/Asela/20200909_methylation/00_Quality_assesment/20200909_filenames.txt"

PROJECT_DIR=~/Documents/Asela/20200909_methylation

PREPRO=/home/labcomputer/Documents/Asela/20200909_methylation/01_Quality_assesment/PREPROCESSING/Adapter_Removed

ALIGN=/media/labcomputer/Seagate\ Expansion\ Drive/20200909_methylation/02_alignment

#mkdir $ALIGN







###################################SOFTWARE SETTINGS##################################################################
###Q_TRIM AND ADAPTER REMOVING#####

Genome_path=/home/labcomputer/Documents/Asela/data/W82-Rpsk1/genome/Soy_ecoli_chlro_genome

while IFS=" " read -r value1 value2

do {


###################################File downloads#####################################################################

FIRST_SAMPLE_LOC=${PREPRO}/${value1}_trim_R1.fastq
SECCOND_SAMPLE_LOC=${PREPRO}/${value1}_trim_R2.fastq


#first_read =W82-Rpsk1_L001_R1.fastq, W82-Rpsk1_L002_R1.fastq, W82-Rpsk1_L003_R1.fastq, W82-Rpsk1_L004_R1.fastq

#second_read =<W82-Rpsk1_L001_R2.fastq, W82-Rpsk1_L002_R2.fastq, W82-Rpsk1_L003_R2.fastq, W82-Rpsk1_L004_R2.fastq>
#######################################################################################################################


####################################Adapter Removing####################################################################

cd $ADP_REM
bismark --non_directional $Genome_path -1 $FIRST_SAMPLE_LOC \
  -2 $SECCOND_SAMPLE_LOC -o $ALIGN
  
cd "/media/labcomputer/Seagate Expansion Drive/20200909_methylation/02_alignment" 

deduplicate_bismark -p ${value1}_R1_trim_bismark_bt2_pe.bam  -o ${value1}_trim

cd "/media/labcomputer/Seagate Expansion Drive/20200909_methylation/02_alignment"

bismark_methylation_extractor --bedGraph --gzip ${value1}_trim.deduplicated.bam

} done <"$file"



#conda deactivate


#conda deactivate
