##################
# Load the relevant packages that will be used:
##################

# Run this once and then you don't have to again: --->
if (!require("devtools")) install.packages("devtools")
library(devtools)
devtools::install_github("Nicktz/rmsfuns")
library(rmsfuns)
#------>

source("Code/packageloads.R")

# Note please change inside the packageload script all the relevant packages. 
# There is an in-built function that will install a package if not allready installed
# and load it into the library. 

###################
# Load the data into R:
###################

Assigned_to <- read_csv("Data/assigned_to.csv") %>% arrange(id)

bug_status <- read_csv("Data/bug_status.csv") %>% arrange(id)

cc <- read_csv("Data/cc.csv") %>% arrange(id) 
# NB some observations shifted and would need to be fixed. Some rows have 2 email adresses. 

# There are no duplicate ID numbers in the reports file: 
anyDuplicated(reports$id)

component <- read_csv("Data/component.csv") %>% arrange(id)
# Note: some ID's have more than 1 subsystem. 

op_sys <- read_csv("Data/op_sys.csv") %>% arrange(id)

# See all the different operating systems. 
unique(op_sys$what)

priority <- read_csv("Data/priority.csv") %>% arrange(id)

product <- read_csv("Data/product.csv") %>% arrange(id)

# See all the unique products:
unique(product$what)
anyDuplicated(product$id)

reports <- read_csv("Data/reports.csv") %>% arrange(id)
# Only 2 things are unchangeable in all the datafiles: The reporter and the opening time of the bug. 

resolution <- read_csv("Data/resolution.csv") %>% arrange(id)
# This shows if the bug has been fixed and by which developer. 

severity <- read_csv("Data/severity.csv") %>% arrange(id)

short_desc <- read_csv("Data/short_desc.csv") %>% arrange(id)
# Warning also parsing failures. Some rows have more than one description. 

version <- read_csv("Data/version.csv") %>% arrange(id)

##################
# Data Manipulation
##################

# I think we need to try and summarise in one file all the important attributes that we want to 
# regress on FIXED. Therefore, we do NOT try to create one big dataset out of all the raw datasets.
# There are too many variable that makes this tricky to do and we are likely to make a mistake. So
# I suggest we try and answer all the questions posed in assigment first and get all that data into 
# one table:

# 1. Past success rate influence likelihood of bug being fixed:



# 2. Reputation of bug reporter and pass success rate on chances of bug being fixed. 

# Filter for values of reports FIXED and WONTFIX under current resolution 
# and create variables for fixed and past success rate of reporter (NOTE needs to be assigned to):

Reports1 <- reports %>% filter(current_resolution == "FIXED" | current_resolution == "WONTFIX") %>% 
  mutate(fixed_dummy = ifelse(current_resolution == "FIXED", 1, 0)) %>% mutate(Total = 1) %>% 
  group_by(reporter) %>% mutate(past_success = sum(fixed_dummy)/sum(Total)) %>% select(-Total)

# See if any ID's are duplicated, should be none:
anyDuplicated(Reports1$id)
# See summary of past success rate by reporter:
Reports1 %>% group_by(reporter) %>% summarise(pastSuccess = mean(past_success)) 