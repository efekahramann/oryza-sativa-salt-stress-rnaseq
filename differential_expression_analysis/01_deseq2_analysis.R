```r
# ============================================================
# 01_deseq2_analysis.R
# Differential gene expression analysis using DESeq2
# ============================================================
# This script reads featureCounts output files, creates a count matrix,
# performs DESeq2 analysis, and exports upregulated/downregulated genes.
# ============================================================


# ============================================================
# Working directory
# ============================================================
# Set the working directory to the project folder containing count.out files.
# Example:
# setwd("path/to/PRJNA493923_Ranaliz")

getwd()
list.files()


# ============================================================
# Load required packages
# ============================================================

library(DESeq2)
library(dplyr)
library(tibble)


# ============================================================
# Create output folder
# ============================================================

dir.create("Results", showWarnings = FALSE)


# ============================================================
# Function to read featureCounts output
# ============================================================

read_featurecounts <- function(file, sample_name) {
  
  df <- read.delim(file, comment.char = "#", check.names = FALSE)
  
  counts <- df[, c("Geneid", colnames(df)[ncol(df)])]
  
  colnames(counts) <- c("Geneid", sample_name)
  
  return(counts)
}


# ============================================================
# Read count files
# ============================================================
# Example design: 2 Control + 2 Treatment
# Replace file names according to the BioProject.

control1 <- read_featurecounts("Kontrol1_count.out", "Control_1")
control2 <- read_featurecounts("Kontrol2_count.out", "Control_2")

treatment1 <- read_featurecounts("Deney1_count.out", "Treatment_1")
treatment2 <- read_featurecounts("Deney2_count.out", "Treatment_2")


# ============================================================
# Merge count files into a count matrix
# ============================================================

count_data <- control1 %>%
  inner_join(control2, by = "Geneid") %>%
  inner_join(treatment1, by = "Geneid") %>%
  inner_join(treatment2, by = "Geneid")

count_matrix <- as.data.frame(count_data)

rownames(count_matrix) <- count_matrix$Geneid
count_matrix <- count_matrix[, -1]

count_matrix <- as.matrix(count_matrix)
mode(count_matrix) <- "numeric"

head(count_matrix)
dim(count_matrix)
colnames(count_matrix)


# ============================================================
# Create metadata table
# ============================================================

metadata <- data.frame(
  sample = colnames(count_matrix),
  condition = c(
    "Control", "Control",
    "Treatment", "Treatment"
  )
)

rownames(metadata) <- metadata$sample

metadata$condition <- factor(
  metadata$condition,
  levels = c("Control", "Treatment")
)

metadata


# ============================================================
# Create DESeq2 object
# ============================================================

dds <- DESeqDataSetFromMatrix(
  countData = round(count_matrix),
  colData = metadata,
  design = ~ condition
)

# Low-count gene filtering
dds <- dds[rowSums(counts(dds)) > 10, ]


# ============================================================
# Run DESeq2 analysis
# ============================================================

dds <- DESeq(dds)

res <- results(
  dds,
  contrast = c("condition", "Treatment", "Control")
)

summary(res)


# ============================================================
# Export all DESeq2 results
# ============================================================

res_df <- as.data.frame(res) %>%
  rownames_to_column("Geneid") %>%
  arrange(padj)

write.csv(
  res_df,
  "Results/DESeq2_results_all.csv",
  row.names = FALSE
)

write.table(
  res_df,
  "Results/DESeq2_results_all.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)


# ============================================================
# Define significantly upregulated and downregulated genes
# ============================================================
# Criteria:
# padj < 0.05
# |log2FoldChange| >= 1

up_genes <- res_df %>%
  filter(!is.na(padj)) %>%
  filter(padj < 0.05, log2FoldChange >= 1)

down_genes <- res_df %>%
  filter(!is.na(padj)) %>%
  filter(padj < 0.05, log2FoldChange <= -1)

nrow(up_genes)
nrow(down_genes)


# ============================================================
# Export upregulated and downregulated gene lists
# ============================================================

write.csv(
  up_genes,
  "Results/up_genes.csv",
  row.names = FALSE
)

write.csv(
  down_genes,
  "Results/down_genes.csv",
  row.names = FALSE
)

write.table(
  up_genes,
  "Results/up_genes.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)

write.table(
  down_genes,
  "Results/down_genes.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)


# ============================================================
# Export normalized counts
# ============================================================

normalized_counts <- counts(dds, normalized = TRUE)

normalized_counts_df <- as.data.frame(normalized_counts) %>%
  rownames_to_column("Geneid")

write.csv(
  normalized_counts_df,
  "Results/normalized_counts.csv",
  row.names = FALSE
)

write.table(
  normalized_counts_df,
  "Results/normalized_counts.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)


# ============================================================
# Save R objects for downstream visualization scripts
# ============================================================

saveRDS(dds, "Results/dds_object.rds")
saveRDS(res, "Results/deseq2_results_object.rds")
saveRDS(res_df, "Results/deseq2_results_table.rds")
saveRDS(metadata, "Results/metadata.rds")
```
