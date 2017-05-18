if (!require("devtools")) install.packages("devtools")
library(devtools)
devtools::install_github("Nicktz/rmsfuns")
library(rmsfuns)

packagestoload <- 
c("tidyr", "dplyr" ,"readr", "tibble", "Dplyr2Xts","lubridate", 
  "ggplot2", "purrr", "xts","PerformanceAnalytics","TTR","ggthemes",
  "PortfolioAnalytics","rportfolios","xtable","magick")

# This loads all packages and installs the package(from CRAN only) if not already in library.
load_pkg(packagestoload)
