```bash
#!/bin/bash

# ============================================================
# 02_fastqc_multiqc.sh
# Quality control of paired-end RNA-seq FASTQ files
# ============================================================
# This script was adapted from the RNA-seq analysis workflow provided by
# Prof. Dr. Emre Yörük and reorganized for this thesis project.
# ============================================================


# ============================================================
# Installation with conda
# ============================================================
# FastQC and MultiQC were installed using conda.
# These installation commands should be run only once.

# conda install -c bioconda fastqc
# conda install -c bioconda multiqc


# ============================================================
# FastQC analysis
# ============================================================
# FastQC was used to evaluate read quality, GC content,
# adapter content and sequence duplication.
# Example command for paired-end FASTQ files:

fastqc SRRXXXXXXX_1.fastq SRRXXXXXXX_2.fastq


# ============================================================
# MultiQC report generation
# ============================================================
# If MultiQC gives an error, the MultiQC conda environment can be activated.
# conda activate multiqc_env

# MultiQC summarizes all QC outputs in a single HTML report.
# The "./" argument scans the current working directory.

multiqc ./


# ============================================================
# Notes
# ============================================================
# SRRXXXXXXX_1.fastq : forward reads
# SRRXXXXXXX_2.fastq : reverse reads
# FastQC             : checks per-base quality, GC content, adapter content and sequence duplication
# MultiQC            : summarizes multiple QC reports in a single HTML file
# ./                 : current working directory
```
