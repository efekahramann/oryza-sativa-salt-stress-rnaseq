#!/bin/bash

# ============================================================
# 03_sortmerna_rrna_filtering.sh
# rRNA filtering using SortMeRNA
# ============================================================
# This script was prepared by adapting the SortMeRNA workflow shared by
# Research Assistant Tuna Birgün for this thesis project.
# ============================================================

# Installation
# conda install -c conda-forge sortmerna

# SortMeRNA v4.3.4 database
wget https://github.com/sortmerna/sortmerna/releases/download/v4.3.4/database.tar.gz
tar -zxvf database.tar.gz

# Working directory
cd ~/RNA_seq/2/fastq_clean

# Remove previous temporary files
rm -rf ~/sortmerna/run/*

# rRNA filtering
sortmerna \
--ref ~/sortmerna_db/smr_v4.3_default_db.fasta \
--reads sample_1.fastq \
--reads sample_2.fastq \
--paired_in \
--fastx \
--other sample_clean.fq \
--aligned sample_rrna.fq \
--threads 12 \
--workdir ~/sortmerna/run

# Re-split cleaned reads into paired-end FASTQ files
# reformat.sh is included in BBMap.
# conda install -c bioconda bbmap

reformat.sh \
in=sample_clean.fq \
out1=sample_clean_R1.fq \
out2=sample_clean_R2.fq \
overwrite=t
