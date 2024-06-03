library(dplyr)
library(leaflet)
library(htmlwidgets)
library(mapview)

info <- read.delim("./../03_results/coordinate_info.tsv", header=T, sep="\t")
if(sum(is.na(info$latitude)) > 0){info <- info[-c(which(is.na(info$latitude) == TRUE)),]}

uniq_coord <- unique(info[,c(3,4)])
n_pubs <- c()
anno <- c()
for(c in c(1:dim(uniq_coord)[1])){
  fil_info <- info %>% filter(latitude == uniq_coord[c,1], longitude == uniq_coord[c,2])
  pmids <- unique(fil_info$pmid)
  address <- as.data.frame(table(fil_info$address)) %>% arrange(desc(Freq))
  n_pubs <- c(n_pubs, length(pmids))
  anno <- c(anno, paste0(as.character(length(pmids)), " - ", address$Var1[1]))
}
all_info <- as.data.frame(cbind(uniq_coord, n_pubs, anno))
all_info <- all_info %>% arrange(desc(n_pubs))
all_info <- all_info %>% filter(n_pubs >= 5)

m <- leaflet()
m <- addTiles(m)
m <- addCircleMarkers(m, lng = all_info$longitude, lat = all_info$latitude,
                      radius = sqrt(all_info$n_pubs), popup = all_info$anno)
saveWidget(m, file="./../04_plots/visualize_research_centers.html")
mapshot(m, file = "./../04_plots/visualize_research_centers.png")

