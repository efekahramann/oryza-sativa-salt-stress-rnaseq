```bash
#!/bin/bash

# ============================================================
# 05_star_genome_index.sh
# Genome index generation using STAR
# ============================================================
# This script was adapted from the RNA-seq analysis workflow provided by
# Prof. Dr. Emre Yörük and reorganized for this thesis project.
# ============================================================

# Installation
# conda install -c bioconda star

# Create project folders
mkdir -p ref
mkdir -p fastq
mkdir -p mapped

# Notes:
# - Place the reference genome FASTA file and GTF annotation file
#   in the main project directory.
# - The ref/ folder will be used by STAR for genome index files.
# - The fastq/ folder should contain trimmed paired-end FASTQ files.
# - The mapped/ folder will be used later for aligned BAM outputs.

# STAR genome index generation
STAR \
--runMode genomeGenerate \
--genomeDir ref/ \
--genomeFastaFiles Oryza_sativa.IRGSP-1.0.dna.toplevel.fa \
--sjdbGTFfile Oryza_sativa.IRGSP-1.0.59.gtf \
--runThreadN 11

# Parameter explanation:
# --runMode genomeGenerate : generates STAR genome index
# --genomeDir              : output directory for genome index files
# --genomeFastaFiles       : reference genome FASTA file
# --sjdbGTFfile            : gene annotation GTF file
# --runThreadN             : number of threads
```
