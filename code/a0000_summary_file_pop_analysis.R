# done on cluster-ceab, where the untracked files are located.
library(data.table)

E2016 = fread("~/research/acs/untracked_data/2012-2016/All_Geog_Not_TBG/e20165us0010000.txt")
M2016 = fread("~/research/acs/untracked_data/2012-2016/All_Geog_Not_TBG/m20165us0010000.txt")

G2016 = fread("~/research/acs/data/ACS_2016_geography_files/US.csv")

(bosnians_US_2016_est = E2016[[1, 49]])
(bosnians_US_2016_me = M2016[[1, 49]])

bosnians_US_2016_est + (bosnians_US_2016_me*c(-1,1))

E2009 = fread("~/research/acs/untracked_data/2005-2009/All_Not_TBG/e20095us0018000.txt")
M2009 = fread("~/research/acs/untracked_data/2005-2009/All_Not_TBG/m20095us0018000.txt")

G2009 = as.data.table(read.fwf("~/research/acs/untracked_data/2005-2009/All_Not_TBG/g20095us.txt",  widths=c(6,2,3,2, 7, -55, 5, -138, 200, -50), col.names=c("FILEID", "STUSAB", "SUMLEVEL", "COMPONENT", "logrec", "CBSA", "Name"), header = FALSE, fileEncoding="ISO-8859-1"))


(bosnians_US_2009_est = E2009[[1, 107]])
(bosnians_US_2009_me = M2009[[1, 107]])

bosnians_US_2009_est + (bosnians_US_2009_me*c(-1,1))

# CBSA

E2016_CBSA_bos = E2016[V6 %in% 5362:6294, c(1:6, 49)]
M2016_CBSA_bos = M2016[V6 %in% 5362:6294, c(1:6, 49)]
saveRDS(E2016_CBSA_bos, file="~/research/acs/data/E2016_CBSA_bos.Rds")
saveRDS(M2016_CBSA_bos, file="~/research/acs/data/M2016_CBSA_bos.Rds")


E2009 = merge(E2009, G2009, by.x="V6", by.y="logrec")
M2009 = merge(M2009, G2009, by.x="V6", by.y="logrec")

E2009_CBSA_bos = E2009[!is.na(CBSA), c(1:6, 107, 232)]
M2009_CBSA_bos = M2009[!is.na(CBSA), c(1:6, 107, 232)]
saveRDS(E2009_CBSA_bos, file="~/research/acs/data/E2009_CBSA_bos.Rds")
saveRDS(M2009_CBSA_bos, file="~/research/acs/data/M2009_CBSA_bos.Rds")



E2016[V6 %in% 5362:6294, list(V6, V49)][order(-V49)]
E2016[V6 == 6103, 49]
E2016[V6 %in% 5362:6294, list(V6, V49)][order(-V49)][1:14, sum(V49)]/E2016[[1, 49]]
E2016[V6 %in% 5362:6294, list(V6, V49)][order(-V49)][1:14]

g20095us.txt 


## counties
stateTLs <- c("al","ak","az","ar","ca","co","ct","de","dc","fl","ga","hi","id","il","in","ia","ks","ky","la","me","md","ma","mi","mn","ms","mo","mt","ne","nv","nh","nj","nm","ny","nc","nd","oh","ok","or","pa","ri","sc","sd","tn","tx","ut","vt","va","wa","wv","wi","wy","pr")

E2016 = rbindlist(lapply(stateTLs, function(s) fread(paste0("~/research/acs/untracked_data/2012-2016/All_Geog_Not_TBG/e20165", s, "0010000.txt"))))
M2016 = rbindlist(lapply(stateTLs, function(s) fread(paste0("~/research/acs/untracked_data/2012-2016/All_Geog_Not_TBG/m20165", s, "0010000.txt"))))

E2009 = rbindlist(lapply(stateTLs, function(s) fread(paste0("~/research/acs/untracked_data/2005-2009/All_Not_TBG/e20095", s, "0010000.txt"))))
M2009 = rbindlist(lapply(stateTLs, function(s) fread(paste0("~/research/acs/untracked_data/2005-2009/All_Not_TBG/m20095", s, "0010000.txt"))))

E2016[,49]

E2009[,107]

