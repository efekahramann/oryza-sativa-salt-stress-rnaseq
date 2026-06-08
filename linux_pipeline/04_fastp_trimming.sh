#!/bin/bash

# ============================================================
# 04_fastp_trimming.sh
# Adapter and low-quality read filtering using fastp
# ============================================================
# This script was adapted from the RNA-seq analysis workflow provided by
# Prof. Dr. Emre Yörük and reorganized for this thesis project.
# ============================================================

# Installation
# conda install -c bioconda fastp

# fastp trimming and filtering
# Replace sample_1.fastq and sample_2.fastq with paired-end FASTQ file names.

fastp \
--in1 sample_1.fastq \
--in2 sample_2.fastq \
--out1 trimmed_sample_1.fastq \
--out2 trimmed_sample_2.fastq

# Parameter explanation:
# --in1   : input forward reads
# --in2   : input reverse reads
# --out1  : trimmed/filtered forward reads
# --out2  : trimmed/filtered reverse reads
