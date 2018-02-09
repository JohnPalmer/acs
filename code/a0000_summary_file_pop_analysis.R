# done on cluster-ceab, where the untracked files are located.
library(data.table)

E2016 = fread("~/research/acs/untracked_data/2012-2016/All_Geog_Not_TBG/e20165us0010000.txt")
M2016 = fread("~/research/acs/untracked_data/2012-2016/All_Geog_Not_TBG/m20165us0010000.txt")

(bosnians_US_2016_est = E2016[[1, 49]])
(bosnians_US_2016_me = M2016[[1, 49]])

bosnians_US_2016_est + (bosnians_US_2016_me*c(-1,1))

E2009 = fread("~/research/acs/untracked_data/2005-2009/All_Not_TBG/e20095us0018000.txt")
M2009 = fread("~/research/acs/untracked_data/2005-2009/All_Not_TBG/m20095us0018000.txt")

(bosnians_US_2009_est = E2009[[1, 107]])
(bosnians_US_2009_me = M2009[[1, 107]])

bosnians_US_2009_est + (bosnians_US_2009_me*c(-1,1))

## counties
stateTLs <- c("al","ak","az","ar","ca","co","ct","de","dc","fl","ga","hi","id","il","in","ia","ks","ky","la","me","md","ma","mi","mn","ms","mo","mt","ne","nv","nh","nj","nm","ny","nc","nd","oh","ok","or","pa","ri","sc","sd","tn","tx","ut","vt","va","wa","wv","wi","wy","pr")

E2016 = rbindlist(lapply(stateTLs, function(s) fread(paste0("~/research/acs/untracked_data/2012-2016/All_Geog_Not_TBG/e20165", s, "0010000.txt"))))
M2016 = rbindlist(lapply(stateTLs, function(s) fread(paste0("~/research/acs/untracked_data/2012-2016/All_Geog_Not_TBG/m20165", s, "0010000.txt"))))

E2009 = rbindlist(lapply(stateTLs, function(s) fread(paste0("~/research/acs/untracked_data/2005-2009/All_Not_TBG/e20095", s, "0010000.txt"))))
M2009 = rbindlist(lapply(stateTLs, function(s) fread(paste0("~/research/acs/untracked_data/2005-2009/All_Not_TBG/m20095", s, "0010000.txt"))))

E2016[,49]

E2009[,107]

