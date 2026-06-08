# ============================================================
# 04_shinygo_input_prepare.R
# Preparation of gene lists for ShinyGO enrichment analysis
# ============================================================
# This script prepares upregulated, downregulated and background
# gene lists for GO/KEGG enrichment analysis using ShinyGO.
# ============================================================


# ============================================================
# Load required packages
# ============================================================

library(dplyr)


# ============================================================
# Load DESeq2 result table
# ============================================================

res_df <- readRDS("Results/deseq2_results_table.rds")


# ============================================================
# Prepare gene lists
# ============================================================

background_genes <- res_df %>%
  filter(!is.na(baseMean)) %>%
  pull(Geneid)

up_gene_list <- res_df %>%
  filter(!is.na(padj)) %>%
  filter(padj < 0.05, log2FoldChange >= 1) %>%
  pull(Geneid)

down_gene_list <- res_df %>%
  filter(!is.na(padj)) %>%
  filter(padj < 0.05, log2FoldChange <= -1) %>%
  pull(Geneid)


# ============================================================
# Export ShinyGO input files
# ============================================================

dir.create("Results/ShinyGO_inputs", showWarnings = FALSE)

write.table(
  background_genes,
  "Results/ShinyGO_inputs/background_gene_list.txt",
  quote = FALSE,
  row.names = FALSE,
  col.names = FALSE
)

write.table(
  up_gene_list,
  "Results/ShinyGO_inputs/up_gene_list.txt",
  quote = FALSE,
  row.names = FALSE,
  col.names = FALSE
)

write.table(
  down_gene_list,
  "Results/ShinyGO_inputs/down_gene_list.txt",
  quote = FALSE,
  row.names = FALSE,
  col.names = FALSE
)


# ============================================================
# Summary
# ============================================================

cat("Background genes:", length(background_genes), "\n")
cat("Upregulated genes:", length(up_gene_list), "\n")
cat("Downregulated genes:", length(down_gene_list), "\n")
