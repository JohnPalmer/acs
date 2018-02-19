# done on cluster-ceab, where the untracked files are located.
library(data.table)

E2009 = readRDS(file="~/research/acs/data/summary_file_tracts_bosnians_median_income.Rds")

saveRDS(E2016, file="~/research/acs/data/summary_file_tracts_bosnians_median_income.Rds")

