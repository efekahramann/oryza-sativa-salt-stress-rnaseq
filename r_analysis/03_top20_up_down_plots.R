# ============================================================
# 03_top20_up_down_plots.R
# Top 20 upregulated and downregulated gene plots
# ============================================================
# This script uses DESeq2 result table generated in
# 01_deseq2_analysis.R and creates top 20 up/down gene plots.
# ============================================================


# ============================================================
# Load required packages
# ============================================================

library(ggplot2)
library(dplyr)


# ============================================================
# Project ID
# ============================================================
# Change this according to the analyzed BioProject.

project_id <- "PRJNA493923"


# ============================================================
# Load DESeq2 result table
# ============================================================

res_df <- readRDS("Results/deseq2_results_table.rds")


# ============================================================
# Select top 20 upregulated and downregulated genes
# ============================================================

top_up <- res_df %>%
  filter(!is.na(padj)) %>%
  filter(padj < 0.05, log2FoldChange >= 1) %>%
  arrange(desc(log2FoldChange)) %>%
  slice(1:20)

top_down <- res_df %>%
  filter(!is.na(padj)) %>%
  filter(padj < 0.05, log2FoldChange <= -1) %>%
  arrange(log2FoldChange) %>%
  slice(1:20)


# ============================================================
# Export top 20 gene tables
# ============================================================

write.csv(
  top_up,
  "Results/top20_up_genes.csv",
  row.names = FALSE
)

write.csv(
  top_down,
  "Results/top20_down_genes.csv",
  row.names = FALSE
)

write.table(
  top_up,
  "Results/top20_up_genes.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)

write.table(
  top_down,
  "Results/top20_down_genes.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)


# ============================================================
# Top 20 upregulated genes plot
# ============================================================

top_up_plot <- ggplot(
  top_up,
  aes(x = reorder(Geneid, log2FoldChange), y = log2FoldChange)
) +
  geom_col() +
  coord_flip() +
  theme_minimal() +
  labs(
    title = paste("Top 20 Upregulated Genes -", project_id),
    x = "Gene ID",
    y = "log2 Fold Change"
  )

ggsave(
  "Results/top20_upregulated_genes.pdf",
  top_up_plot,
  width = 8,
  height = 6
)

ggsave(
  "Results/top20_upregulated_genes.png",
  top_up_plot,
  width = 8,
  height = 6,
  dpi = 300
)


# ============================================================
# Top 20 downregulated genes plot
# ============================================================

top_down_plot <- ggplot(
  top_down,
  aes(x = reorder(Geneid, log2FoldChange), y = log2FoldChange)
) +
  geom_col() +
  coord_flip() +
  theme_minimal() +
  labs(
    title = paste("Top 20 Downregulated Genes -", project_id),
    x = "Gene ID",
    y = "log2 Fold Change"
  )

ggsave(
  "Results/top20_downregulated_genes.pdf",
  top_down_plot,
  width = 8,
  height = 6
)

ggsave(
  "Results/top20_downregulated_genes.png",
  top_down_plot,
  width = 8,
  height = 6,
  dpi = 300
)
