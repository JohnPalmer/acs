library(data.table)
library(tidyverse)

E2016 = as.tibble(readRDS(file="~/research/acs/data/E2016_CBSA_bos.Rds")) %>%
  full_join(select(as.tibble(readRDS(file="~/research/acs/data/M2016_CBSA_bos.Rds")), LOGRECNO, MoE_B=BOSCOUNT, MoE_FB=FOREIGNBORN, MoE_T=TOTALPOP)) %>% 
  select(LOGRECNO, GEOID, Name, BOSCOUNT, MoE_B, FB=FOREIGNBORN, MoE_FB, TOTALPOP, MoE_T) %>% 
#  mutate(ci90ll=BOSCOUNT-MoE, ci90ul=BOSCOUNT+MoE) %>%
#  mutate(ci90ll=case_when(ci90ll<0~as.integer(0), ci90ll>=0~ci90ll)) %>%
  mutate(CBSA=as.integer(substr(GEOID, 8, 12))) %>%
  arrange(desc(BOSCOUNT))

E2009 = as.tibble(readRDS(file="~/research/acs/data/E2009_CBSA_bos.Rds")) %>% 
  filter(SUMLEVEL==310) %>% 
  full_join(select(as.tibble(readRDS(file="~/research/acs/data/M2009_CBSA_bos.Rds")), LOGRECNO, MoE_B=BOSCOUNT, MoE_FB=FOREIGNBORN, MoE_T=TOTALPOP)) %>% 
  select(LOGRECNO, Name,  BOSCOUNT, MoE_B, FB=FOREIGNBORN, MoE_FB, TOTALPOP, MoE_T, CBSA) %>% 
#  mutate(ci90ll=BOSCOUNT-MoE, ci90ul=BOSCOUNT+MoE) %>%
#  mutate(ci90ll=case_when(ci90ll<0~as.integer(0), ci90ll>=0~ci90ll)) %>%
  arrange(desc(BOSCOUNT))

D = E2009 %>% full_join(select(E2016, CBSA, N_B_2016=BOSCOUNT, MoE_B_2016=MoE_B, N_FB_2016=FB, MoE_FB_2016=MoE_FB, N_T_2016=TOTALPOP, MoE_T_2016=MoE_T)) %>%
  select(Name, CBSA, N_B_2009=BOSCOUNT, N_B_2016, MoE_B_2009=MoE_B, MoE_B_2016, N_FB_2009=FB, N_FB_2016, MoE_FB_2009=MoE_FB, MoE_FB_2016, N_T_2009=TOTALPOP, N_T_2016, MoE_T_2009=MoE_T, MoE_T_2016) %>%
  mutate(diff_B=N_B_2016-N_B_2009, MoE_diff_B=sqrt((MoE_B_2009^2)+(MoE_B_2016^2)), sig_diff_B=(abs(diff_B)/MoE_diff_B)>1, diff_T=N_T_2016-N_T_2009, MoE_diff_T=sqrt((MoE_T_2009^2)+(MoE_T_2016^2)), sig_diff_T=(abs(diff_T)/MoE_diff_T)>1, diff_FB=N_FB_2016-N_FB_2009, MoE_diff_FB=sqrt((MoE_FB_2009^2)+(MoE_FB_2016^2)), sig_diff_FB=(abs(diff_FB)/MoE_diff_FB)>1) %>%
  arrange(desc(N_B_2009))

D %>% filter(sig_diff_B) %>% select(Name, N_B_2009, N_B_2016, diff_B, diff_FB, sig_diff_FB, diff_T, sig_diff_T) %>% arrange(diff_B)

saveRDS(D, file="~/research/acs/data/cbsa_bosnian_counts.Rds")
