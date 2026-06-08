#!/bin/bash

# ============================================================
# 06_star_alignment.sh
# Alignment of cleaned paired-end FASTQ files using STAR
# ============================================================
# This script was adapted from the RNA-seq analysis workflow provided by
# Prof. Dr. Emre Yörük and reorganized for this thesis project.
# ============================================================

# Go to the folder containing cleaned paired-end FASTQ files
cd fastq

# STAR alignment for paired-end reads
# Replace sample_clean_R1.fq and sample_clean_R2.fq with the corresponding sample files.

STAR \
--runMode alignReads \
--genomeDir ../ref/ \
--readFilesIn sample_clean_R1.fq sample_clean_R2.fq \
--outSAMtype BAM SortedByCoordinate \
--runThreadN 11 \
--outFileNamePrefix ../mapped/sample_

# ============================================================
# Output files in mapped/
# ============================================================
# sample_Aligned.sortedByCoord.out.bam
#   Coordinate-sorted BAM file used as input for featureCounts.
#
# sample_Log.final.out
#   STAR alignment summary report.
#
# sample_Log.out
#   Detailed STAR run log.
#
# sample_SJ.out.tab
#   Splice junction output file.
