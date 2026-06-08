# oryza-sativa-salt-stress-rnaseq
# Oryza sativa Salt Stress RNA-seq Analysis

This repository contains the Linux pipeline scripts and R analysis codes used for the transcriptomic analysis of *Oryza sativa* under salt stress.

The study focuses on identifying differentially expressed genes and enriched biological pathways in rice datasets exposed to NaCl stress.

## Project Aim

The aim of this analysis is to investigate transcriptomic responses of *Oryza sativa* under salt stress using publicly available RNA-seq datasets. Differential gene expression and enrichment analyses were performed to identify stress-related molecular responses in root, shoot and seedling tissues.

## General Pipeline

1. Raw RNA-seq data were downloaded from NCBI SRA using SRA Toolkit.
2. Initial quality control was performed using FastQC and MultiQC.
3. rRNA reads were filtered out using SortMeRNA.
4. Low-quality reads and adapter sequences were filtered using fastp.
5. Clean reads were aligned to the *Oryza sativa* IRGSP-1.0 reference genome using STAR.
6. Gene-level read counts were generated using Subread/featureCounts.
7. Differential gene expression analysis was performed in R using DESeq2.
8. Upregulated and downregulated gene sets were used for GO/KEGG enrichment analysis with ShinyGO.

## Reference Files

Reference genome:

```text
Oryza_sativa.IRGSP-1.0.dna.toplevel.fa
```

Gene annotation file:

```text
Oryza_sativa.IRGSP-1.0.59.gtf
```

## Repository Structure

```text
linux_pipeline/
```
Contains shell scripts used for data download, quality control, preprocessing, alignment and read counting.

```text
r_analysis/
```

Contains R scripts used for DESeq2 analysis, PCA, MA plot, volcano plot, heatmap and top up/down gene visualizations.

```text
metadata/
```

Contains sample information and BioProject summary tables.

```text
shinygo_inputs/
```

Contains upregulated, downregulated and background gene lists prepared for ShinyGO enrichment analysis.

```text
example_outputs/
```

Contains representative output figures such as PCA plots, volcano plots, heatmaps and enrichment plots.

## Main Tools and Packages

### Linux-based tools

* SRA Toolkit
* FastQC
* MultiQC
* SortMeRNA
* fastp
* STAR
* Subread / featureCounts

### R packages

* DESeq2
* ggplot2
* dplyr
* tibble
* pheatmap
* ggrepel

## Differential Expression Criteria

Differentially expressed genes were selected based on adjusted p-value and log2 fold change thresholds.

```text
padj < 0.05
|log2FoldChange| ≥ 1
```

Upregulated and downregulated genes were analyzed separately.

## Enrichment Analysis

GO/KEGG enrichment analyses were performed using ShinyGO. Upregulated and downregulated gene sets were uploaded separately, and enrichment results were evaluated based on FDR values.

## Notes

Raw FASTQ files, BAM files, STAR index files and other large intermediate files are not included in this repository due to file size limitations.

## Authors

Mazlum Efe Kahraman
Emincan Murat

Advisor: Prof. Dr. Emre Yörük
Department of Molecular Biology and Genetics
İstanbul Yeni Yüzyıl University

## Acknowledgements

We would like to thank Research Assistant Tuna Birgün for his valuable guidance, support and contributions during the thesis process.
