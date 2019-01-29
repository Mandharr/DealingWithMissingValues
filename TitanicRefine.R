# Exercise
# 
# Using R, you’ll be handling missing values in this data set, and creating a new data set. Specifically, these are the tasks you need to do:
#   
#   0: Load the data in RStudio
# 
# Save the data set as a CSV file called titanic_original.csv and load it in RStudio into a data frame.
# 
# 1: Port of embarkation
# 
# The embarked column has some missing values, which are known to correspond to passengers who actually embarked at Southampton. Find the missing values and replace them with S. (Caution: Sometimes a missing value might be read into R as a blank or empty string.)
# 
# 2: Age
# 
# You’ll notice that a lot of the values in the Age column are missing. While there are many ways to fill these missing values, using the mean or median of the rest of the values is quite common in such cases.
# 
# Calculate the mean of the Age column and use that value to populate the missing values
# 
# Think about other ways you could have populated the missing values in the age column. Why would you pick any of those over the mean (or not)?
#   
#   3: Lifeboat
# 
# You’re interested in looking at the distribution of passengers in different lifeboats, but as we know, many passengers did not make it to a boat :-( This means that there are a lot of missing values in the boat column. Fill these empty slots with a dummy value e.g. the string 'None' or 'NA'
#                                                                                                                                                      
#   4: Cabin
#                                                                                                                                                      
# You notice that many passengers don’t have a cabin number associated with them.
#                                                                                                                                                      
# Does it make sense to fill missing cabin numbers with a value?
#                                                                                                                                                        
# What does a missing value here mean?
#                                                                                                                                                        
# You have a hunch that the fact that the cabin number is missing might be a useful indicator of survival. Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.
#
#   5: Submit the project on Github
#
# Include your code, the original data as a CSV file titanic_original.csv, and the cleaned up data as a CSV file called titanic_clean.csv.

library(dplyr)
library(tidyr)
library(xlsx)

# Read titanic3.xlsx the excel file
df <- read.xlsx("titanic3.xlsx", 1)

# Write the datframe as ".CSV" file
write.csv(df, "titanic_original.csv")

# read the "titanic_original.CSV" file for manipulation
refine <- read.csv(file= "titanic_original.csv")

# Remove Sr.No column ( X ) from the dataframe
refine <- subset(refine, select = -c(X))

# Port of Embarkation

y <- which(is.na(refine$embarked) ==TRUE)
refine$embarked[y] <- "S"

# Missing Age Value
y <- which(is.na(refine$age) == TRUE)
refine$age[y] <- mean(refine$age, na.rm = TRUE) 

# Filling Dummy Values for Column LifBoat
y <- which(is.na(refine$boat) == TRUE)
refine$boat[y] <- "NONE"

# Creating column has_cbin_number

refine$has_cabin_number <- refine$cabin
y <- which(is.na(refine$has_cabin_number) == TRUE)
refine$has_cabin_number <- as.character(refine$has_cabin_number)
refine$has_cabin_number[y] <- 0

# For Cabin with values

refine <- refine %>% mutate(has_cabin_number = gsub(pattern = "A.*|B.*|C.*|D.*|E.*|F.*|G.*|H.*|I.*|J.*|K.*|L.*|M.*|N.*|O.*|P.*|Q.*|R.*|S.*|T.*|U.*|V.*|W.*|X.*|Y.*|Z.*", replacement = 1, x = has_cabin_number))

# Write to file

write.csv(refine, file = "titanic_clean.csv")

