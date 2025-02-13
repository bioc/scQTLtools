% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/createGeneLoc-callQTL.R
\name{createGeneLoc}
\alias{createGeneLoc}
\title{Create gene location dataframe.}
\usage{
createGeneLoc(
  geneList,
  gene_mart = NULL,
  geneDataset = "hsapiens_gene_ensembl",
  OrgDb
)
}
\arguments{
\item{geneList}{A gene id or a list of genes id.}

\item{gene_mart}{An object of class `Mart` representing the BioMart database
connect to for gene. If provided, this should be a `Mart` object obtained by
calling `useEnsembl()`, which allows specifying a mirror in case of
connection issues. If `NULL`, the function will create and use a `Mart`
object pointing to the Ensembl Gene BioMart using the specified
`geneDataset` and a default mirror.}

\item{geneDataset}{A character string specifying the gene dataset to use
from ENSEMBL. The default is "hsapiens_gene_ensembl" for human genes.}

\item{OrgDb}{OrgDb name:"org.Hs.eg.db", "org.Mm.eg.db".}
}
\value{
data.frame
}
\description{
Create gene location dataframe.
}
\examples{
data(testGene)
geneList <- rownames(testGene)
library(GOSemSim)
library(biomaRt)
OrgDb <- load_OrgDb("org.Hs.eg.db")
gene_mart <- useEnsembl(biomart = "genes",
                        dataset = "hsapiens_gene_ensembl",
                        mirror = 'asia')
gene_loc <- createGeneLoc(geneList = geneList,
                          gene_mart = gene_mart,
                          OrgDb = OrgDb)
}
