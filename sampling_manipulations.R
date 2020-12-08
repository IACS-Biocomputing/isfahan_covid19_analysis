library(tidyverse)
library(haven)
library(caret)

Farvadin_2 <- read_dta("fwdcovid19/15 Farvardin-2 dleted missing discharge date.dta", encoding = "windows-1256") %>% 
  mutate (Outcome = as.factor(Outcome))

# Following this tutorial 
# https://www.analyticsvidhya.com/blog/2016/03/practical-guide-deal-imbalanced-classification-problems/
# But using the caret upSample/downSample

table(Farvadin_2$Outcome)
prop.table(table(Farvadin_2$Outcome))

# Oversampling -----

Farvadin_2_balanced_over <- upSample(Farvadin_2 %>% select(-Outcome), Farvadin_2$Outcome, yname="Outcome")

table(Farvadin_2_balanced_over$Outcome)
prop.table(table(Farvadin_2_balanced_over$Outcome))

trainIndex_over <- createDataPartition(as.factor(Farvadin_2_balanced_over$Outcome), p=0.80, list=FALSE)
Farvadin_2_balanced_over_train <- Farvadin_2_balanced_over[as.vector(trainIndex_over),]
Farvadin_2_balanced_over_test <- Farvadin_2_balanced_over[-as.vector(trainIndex_over),]

saveRDS(Farvadin_2_balanced_over_train, "Farvadin_2_balanced_over_train_80.Rda")
write_dta(Farvadin_2_balanced_over_train, "Farvadin_2_balanced_over_train80.dta")
saveRDS(Farvadin_2_balanced_over_test, "Farvadin_2_balanced_over_test_20.Rda")
write_dta(Farvadin_2_balanced_over_test, "Farvadin_2_balanced_over_test_20.dta")

# Undersampling ----

Farvadin_2_balanced_under <- downSample(Farvadin_2 %>% select(-Outcome), Farvadin_2$Outcome, yname="Outcome")

table(Farvadin_2_balanced_under$Outcome)
prop.table(table(Farvadin_2_balanced_under$Outcome))

trainIndex_under <- createDataPartition(as.factor(Farvadin_2_balanced_under$Outcome), p=0.80, list=FALSE)
Farvadin_2_balanced_under_train <- Farvadin_2_balanced_under[as.vector(trainIndex_under),]
Farvadin_2_balanced_under_test <- Farvadin_2_balanced_under[-as.vector(trainIndex_under),]

saveRDS(Farvadin_2_balanced_under_train, "Farvadin_2_balanced_under_train_80.Rda")
write_dta(Farvadin_2_balanced_under_train, "Farvadin_2_balanced_under_train80.dta")
saveRDS(Farvadin_2_balanced_under_test, "Farvadin_2_balanced_under_test_20.Rda")
write_dta(Farvadin_2_balanced_under_test, "Farvadin_2_balanced_under_test_20.dta")
