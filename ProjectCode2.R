# Questions to Answer:

########################
# 1. Past success rate influence likelihood of bug being fixed:
########################

# Filter for values of reports FIXED and WONTFIX under current resolution 
# and create variables for fixed and past success rate:

Reports1 <- reports %>% filter(current_resolution == "FIXED" | current_resolution == "WONTFIX") %>% 
            mutate(fixed_dummy = ifelse(current_resolution == "FIXED", 1, 0)) %>% mutate(Total = 1) %>% 
            group_by(reporter) %>% mutate(past_success = sum(fixed_dummy)/sum(Total)) %>% select(-Total)
 
# See if any ID's are duplicated, should be none:
anyDuplicated(Reports1$id)
# See summary of past success rate by reporter:
Reports1 %>% group_by(reporter) %>% summarise(pastSuccess = mean(past_success)) 

### Now Run Naive Bayes Regression:

library(e1071)
naiveBayes(fixed_dummy ~ past_success, data = Reports1)

### Random Forest

library(randomForest)
randomForest()

###### IF RESOLUTION USED: ########
# Make a dummy variable for whether a particular bug has been fixed or not: 
# Fixed <- resolution %>% filter(!is.na(what)) %>% arrange(id, when) %>% group_by(id) %>% filter(row_number()==n()) %>%
#  mutate(fixed_dummy = ifelse(what == "FIXED", 1, 0))