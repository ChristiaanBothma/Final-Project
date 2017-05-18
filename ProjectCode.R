# Load the relevant packages that will be used:
source("Code/packageloads.R")

# Load the data into R:

Assigned_to <- read_csv("Data/assigned_to.csv") %>% arrange(id)

bug_status <- read_csv("Data/bug_status.csv") %>% arrange(id)

cc <- read_csv("Data/cc.csv") %>% arrange(id) 
# NB some observations shifted and would need to be fixed. Some rows have 2 email adresses. 

reports <- read_csv("Data/reports.csv") %>% arrange(id)

# Only 2 things are unchangeable: The reporter and the opening time of the bug. 
# The id can change... (this reported in the reports file). The reports file can already 
# be used to run a regression -> reporter ~ Fixed. 

# There are no duplicate ID numbers in the reports file: 
anyDuplicated(reports$id)

component <- read_csv("Data/component.csv") %>% arrange(id)
# Note some ID's have more than 1 subsystem. 

op_sys <- read_csv("Data/op_sys.csv") %>% arrange(id)

# See all the different operating systems. 
unique(op_sys$what)

priority <- read_csv("Data/priority.csv") %>% arrange(id)

product <- read_csv("Data/product.csv") %>% arrange(id)

unique(product$what)
anyDuplicated(product$id)

resolution <- read_csv("Data/resolution.csv") %>% arrange(id)
# This shows if the bug has been fixed and by which developer. 

severity <- read_csv("Data/severity.csv") %>% arrange(id)

short_desc <- read_csv("Data/short_desc.csv") %>% arrange(id)
# Warning also parsing failures... 

version <- read_csv("Data/version.csv") %>% arrange(id)







