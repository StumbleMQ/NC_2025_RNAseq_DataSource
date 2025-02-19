Sys.setenv(LANGUAGE = "en")
options(stringsAsFactors = FALSE)
rm(list=ls())
### 
setwd("~/Downloads/NC_2025_RNAseq_DataSource/MainFigure/Figure_4a")
### 
library(dplyr)
library(tidyverse)
library(ggplot2)                         
library(ggrepel)                               

### select several well-known M1 and M2 markers to build up a M1_M2.csv file: 
M1_M2_hm <- read.csv("M1_M2.csv", header = TRUE,
                     stringsAsFactors = FALSE)
View(M1_M2_hm)
################################################################################
## build a heat-map graph
## library(dplyr)
## load normalized expression files of the wild type BMDM cells subjected to LPS 
### treated with and without ML-SA5.
BMDMLPS_exprSetrlog <- read.csv("exprSetrlog_BMDM_DESeq2.csv")
View(BMDMLPS_exprSetrlog)

M1_M2_hm_list <- unlist(M1_M2_hm$M1_M2)
M1_M2_hm_list

### retrieve the expression data of several well known markers:

M1_M2_hm_df <- BMDMLPS_exprSetrlog[BMDMLPS_exprSetrlog$X %in% M1_M2_hm_list, ]
View(M1_M2_hm_df)

rownames(M1_M2_hm_df) <- M1_M2_hm_df$X
View(M1_M2_hm_df)
M1_M2_hm_df <- M1_M2_hm_df[,-1]
M1_M2_hm_df_gene <- as.data.frame(M1_M2_hm_df)

annotation_col1 = data.frame(
  Treatment =c(rep("MLSA5",4),rep("Control",4)),
  BMDM.Model =c(rep("LPS",8)))

View(annotation_col1)
rownames(annotation_col1)=colnames(M1_M2_hm_df_gene)
View(M1_M2_hm_df_gene)
### build a hear map graph
library(pheatmap)
pheatmap::pheatmap(M1_M2_hm_df_gene, 
                   cluster_rows =T,
                   cluster_cols =T,
                   annotation_col =annotation_col1,
                   show_colnames=F,
                   scale = "row", 
                   color =colorRampPalette(c("dark blue", "white","Red"))(100))
########### End ##########################################


