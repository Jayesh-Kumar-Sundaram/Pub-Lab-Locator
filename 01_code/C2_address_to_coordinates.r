#https://jessecambon.github.io/tidygeocoder/articles/geocoder_services.html
library(tidygeocoder)
info <- read.delim("./../03_results/address_pmid_info.tsv", header=F, sep="\t")
colnames(info) <- c("address", "pmid")

res_all <- c()
num_query <- 3
q <- dim(info)[1] %/% num_query
r <- dim(info)[1] %% num_query
for(l in c(1:q)){
  a <- ((num_query*(l-1))+1); b <- num_query*l
  res <- geocode(info[a:b,], address, method = 'arcgis', lat = latitude , long = longitude)
  Sys.sleep(1)
  res_all <- rbind(res_all, as.matrix(res))
}
a <- (num_query*l)+1; b <- (num_query*l)+r
res <- geocode(info[a:b,], address, method = 'arcgis', lat = latitude , long = longitude)
res_all <- rbind(res_all, as.matrix(res))
write.table(x=res_all, file="./../03_results/coordinate_info.tsv", append=FALSE, quote=FALSE, sep="\t", row.names = FALSE, col.names = TRUE)
