#' Check if the SNP ids in the input genotype matrix are valid.
#'
#' @param snpList a list of SNPs id.
#' @param snp_mart An object of class `Mart` representing the BioMart database
#' connect to for SNPs. If provided, this should be a `Mart` object obtained by
#' calling `useEnsembl()`, which allows specifying a mirror in case of
#' connection issues. If `NULL`, the function will create and use a `Mart`
#' object pointing to the Ensembl SNP BioMart using the specified `snpDataset`
#' and a default mirror.
#' @param snpDataset A character string specifying the SNP dataset to use from
#' ENSEMBL. The default is 'hsapiens_snp' for human SNPs.
#' @return SNP location dataframe
#' @export
#' @examples
#' data(testSNP2)
#' snpList <- rownames(testSNP2)
#' snpDataset <- 'hsapiens_snp'
#' snps_loc <- checkSNPList(snpList = snpList,
#'                         snpDataset = snpDataset)
checkSNPList <- function(snpList,
                        snp_mart = NULL,
                        snpDataset = 'hsapiens_snp') {
    if (grepl("^rs", snpList[[1]][1])) {
        createSNPsLoc(snpList, snp_mart, snpDataset)
    } else if (grepl("\\d+:\\d+", snpList[[1]][1])) {
        snps_df <- data.frame(refsnp_id = character(),
                            chr_name = character(),
                            position = numeric(),
                            stringsAsFactors = FALSE)
        snps_loc_list <- lapply(snpList, function(snp) {
            snp_parts <- strsplit(snp, ":")[[1]]
            data.frame(refsnp_id = snp,
                        chr_name = snp_parts[1],
                        position = as.numeric(snp_parts[2]))
        })
        snps_loc1 <- do.call(rbind, snps_loc_list)
        return(snps_loc1)
    } else {
        return(NULL)
    }
}
