#!/bin/bash

####################################CONFIGERATION INFORMATION#########################################################
###LOCATIONS AND SAMPLE NAMES#########################################################################################

#aligning to the chloroplast genome

PROJECT_DIR=~/Documents/Asela/data/20_DAPseq_data/W82-Rpsk1

PREPRO=${PROJECT_DIR}/PREPROCESSING

ALIGN=~/Documents/Asela/data/20_DAPseq_data/W82-Rpsk1/03_bisulphite_convert_rate/bis_alignment

mkdir $ALIGN


ADP_REM=$PREPRO/QTRIM_DATA




###################################SOFTWARE SETTINGS##################################################################
###Q_TRIM AND ADAPTER REMOVING#####

Genome_path=~/Documents/Asela/data/20_DAPseq_data/W82-Rpsk1/03_bisulphite_convert_rate/chlorplast_genome


#######################################################################################################################


####################################Adapter Removing####################################################################

cd $ADP_REM
bismark --non_directional $Genome_path -1 W82-Rpsk1_combine_R1.fastq \
  -2 W82-Rpsk1_combine_R2.fastq -o $ALIGN
  
cd $ALIGN

deduplicate_bismark -p *_bismark_bt2_pe.bam  -o W82-Rpsk1_combine

cd $ALIGN

bismark_methylation_extractor --bedGraph --gzip W82-Rpsk1_combine.deduplicated.bam
#conda deactivate