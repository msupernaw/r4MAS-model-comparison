# Extract scombrid life history traits from database 

require(tidyverse)

# set working directory 
setwd("~/Documents/GitHub/r4MAS-model-comparison/ASSAMC_comparison/data")

# read data 
scombrid <- read.csv("Global_scombrid_life_history_data_set.csv")

# function to extract life history parameters and compute mean or median 
scombrid.extract <- function(data,type) {
  
  if(type == 'mean') {print(data %>%
                             mutate(Linf = Linf*10,                       # convert to mm 
                                     WL_a = WL_a*(10^WL_b),               # adjust WL_a
                                     #M = 8.87*(k^0.73)*(Linf^-0.33),     # calculate M using Linf
                                     Mest = 4.899*(Tmax^-0.916)) %>%      # calculate M using Tmax 
                             summarise(Linf = mean(Linf, na.rm=T),        # Asymptotic average length
                                     K = mean(k, na.rm=T),                # Growth coefficient
                                     a.lw = mean(WL_a, na.rm=T),          # Parameter a for w-l
                                     b.lw = mean(WL_b, na.rm=T),          # Parameter b for w-l
                                     A50.mat = mean(Tm50, na.rm=T),       # Age at 50% maturity 
                                     slope.mat = mean(Fecundity_slope, na.rm=T), # mat slope
                                     a0 = mean(to, na.rm=T),              # Theoretical age at size 0
                                     Mest = mean(Mest,na.rm=T)))}         # Mortality
  if(type == 'median') {print(data %>%
                              mutate(Linf = Linf*10,                      # convert length units 
                                     WL_a = WL_a*(10^WL_b),               # adjust WL_a
                                     #M = 8.87*(k^0.73)*(Linf^-0.33),     # calculate M using Linf
                                     Mest = 4.899*(Tmax^-0.916)) %>%      # calculate M using Tmax
                              summarise(Linf = median(Linf, na.rm=T),     # Asymptotic average length
                                     K = median(k, na.rm=T),              # Growth coefficient
                                     a.lw = median(WL_a, na.rm=T),        # Parameter a for w-l
                                     b.lw = median(WL_b, na.rm=T),        # Parameter b for w-l
                                     A50.mat = median(Tm50, na.rm=T),     # Age at 50% maturity 
                                     slope.mat = median(Fecundity_slope, na.rm=T), # mat slope
                                     a0 = median(to, na.rm=T),            # Theoretical age at size 0
                                     Mest = median(Mest, na.rm=T)))}      # Mortality
}

# example: calculate mean or median 
scombrid.extract(data = scombrid, type = 'mean')
scombrid.extract(data = scombrid, type = 'median')



