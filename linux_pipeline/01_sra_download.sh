#!/bin/bash
# This script was adapted from the RNA-seq analysis workflow provided by Prof. Dr. Emre Yörük and reorganized for this thesis project.

# ============================================================
# 01_sra_download.sh
# SRA Toolkit installation and paired-end FASTQ download
# ============================================================

# Download SRA Toolkit
wget --output-document sratoolkit.tar.gz \
https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz

# Extract SRA Toolkit
tar -vxzf sratoolkit.tar.gz

# Add SRA Toolkit to PATH
# Note: update the folder name if a newer version is downloaded.
export PATH=$PATH:$PWD/sratoolkit.3.1.0-ubuntu64/bin

# Example command for downloading paired-end RNA-seq data
# Replace SRRXXXXXXX with the target SRA accession number.

fasterq-dump SRRXXXXXXX \
    --split-files \
    -e 4 \
    -O .

# Explanation:
# --split-files : separates paired-end reads into _1 and _2 FASTQ files
# -e 4          : number of threads
# -O .          : saves output files into the current directory
