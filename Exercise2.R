

library(dplyr)

titanic_original <- titanic3

# 1. Port of embarkation
# Find the missing values and replace them with S


filter(titanic3,is.na(embarked))
titanic3$embarked[is.na(titanic3$embarked)] <- "S"



# 2. Age
#Calculate the mean of the Age column and use that value to populate the missing values

filter(titanic3,is.na(age))
mean_age <- mean(titanic3$age,na.rm = TRUE) 
titanic3[is.na(titanic3$age),"age"] <- mean_age


#3. LIFE BOAT
# Fill empty slots with a dummy value e.g. the string 'None' or 'NA'

filter(titanic3,is.na(boat))
filter(titanic3,is.null(boat))

titanic3$boat[is.na(titanic3$boat)] <- "None"

# 4. Cabin
# Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.


titanic3$has_cabin <- as.numeric(!(is.na(titanic3$cabin)))


write.csv(titanic3,file = "titanic_clean_ex2.csv")




