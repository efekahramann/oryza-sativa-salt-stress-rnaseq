```r
# ============================================================
# 02_pca_ma_volcano_heatmap.R
# PCA, MA plot, volcano plot and heatmap visualization
# ============================================================
# This script uses DESeq2 output objects generated in
# 01_deseq2_analysis.R and produces visualization files.
# ============================================================


# ============================================================
# Load required packages
# ============================================================

library(DESeq2)
library(ggplot2)
library(dplyr)
library(pheatmap)


# ============================================================
# Project ID
# ============================================================
# Change this according to the analyzed BioProject.

project_id <- "PRJNA493923"


# ============================================================
# Load saved R objects
# ============================================================

dds <- readRDS("Results/dds_object.rds")
res <- readRDS("Results/deseq2_results_object.rds")
res_df <- readRDS("Results/deseq2_results_table.rds")
metadata <- readRDS("Results/metadata.rds")


# ============================================================
# Variance stabilizing transformation
# ============================================================

vsd <- vst(dds, blind = FALSE)


# ============================================================
# PCA plot
# ============================================================

pca_plot <- plotPCA(vsd, intgroup = "condition") +
  ggtitle(paste("PCA Plot -", project_id)) +
  theme_minimal()

ggsave(
  "Results/PCA_plot.pdf",
  pca_plot,
  width = 6,
  height = 5
)

ggsave(
  "Results/PCA_plot.png",
  pca_plot,
  width = 6,
  height = 5,
  dpi = 300
)

pca_plot


# ============================================================
# MA plot
# ============================================================

pdf("Results/MA_plot.pdf", width = 6, height = 5)

plotMA(
  res,
  ylim = c(-10, 10),
  main = paste("MA Plot -", project_id)
)

dev.off()


png("Results/MA_plot.png", width = 1800, height = 1500, res = 300)

plotMA(
  res,
  ylim = c(-10, 10),
  main = paste("MA Plot -", project_id)
)

dev.off()


# ============================================================
# Volcano plot
# ============================================================

res_df <- res_df %>%
  mutate(
    significance = case_when(
      padj < 0.05 & log2FoldChange >= 1 ~ "Up",
      padj < 0.05 & log2FoldChange <= -1 ~ "Down",
      TRUE ~ "Not significant"
    )
  )

volcano <- ggplot(
  res_df,
  aes(x = log2FoldChange, y = -log10(padj), color = significance)
) +
  geom_point(alpha = 0.7, size = 1.3) +
  theme_minimal() +
  labs(
    title = paste("Volcano Plot -", project_id),
    x = "log2 Fold Change",
    y = "-log10 adjusted p-value"
  )

ggsave(
  "Results/Volcano_plot.pdf",
  volcano,
  width = 7,
  height = 5
)

ggsave(
  "Results/Volcano_plot.png",
  volcano,
  width = 7,
  height = 5,
  dpi = 300
)

volcano


# ============================================================
# Heatmap of top 50 differentially expressed genes
# ============================================================

top_genes <- res_df %>%
  filter(!is.na(padj)) %>%
  arrange(padj) %>%
  slice(1:50) %>%
  pull(Geneid)

mat <- assay(vsd)[top_genes, ]

mat_scaled <- t(scale(t(mat)))

annotation_col <- data.frame(
  condition = metadata$condition
)

rownames(annotation_col) <- rownames(metadata)


pdf("Results/heatmap_top50_genes.pdf", width = 8, height = 10)

pheatmap(
  mat_scaled,
  annotation_col = annotation_col,
  show_rownames = TRUE,
  show_colnames = TRUE,
  main = paste("Top 50 Differentially Expressed Genes -", project_id)
)

dev.off()


png("Results/heatmap_top50_genes.png", width = 2400, height = 3000, res = 300)

pheatmap(
  mat_scaled,
  annotation_col = annotation_col,
  show_rownames = TRUE,
  show_colnames = TRUE,
  main = paste("Top 50 Differentially Expressed Genes -", project_id)
)

dev.off()
```
