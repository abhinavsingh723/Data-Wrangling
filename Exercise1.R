library(tidyverse)

refine_original <- refine


clean_col <- refine %>% 
  
  mutate(lower_company = tolower(company),
         
         first_letter = substr(lower_company, 0, 1), 
         
         clean_company = ifelse(first_letter == "p", "phillips", 
                                
                                ifelse(first_letter == "a", "akzo",
                                       
                                       ifelse(first_letter == "v", "van Houten",
                                              
                                              ifelse(first_letter == "u", "unliever", first_letter))))) 



View(clean_col)

# Separate Product Column

clean_col2 <- clean_col %>%
  separate(`Product code / number`,into = c("prod_code","prod_no"),sep = "-")

View(clean_col2)


# Adding Product Category

prod_code <- c("p", "v", "x", "q")
prod_category <- c("Smartphone", "TV", "Laptop", "Tablet")

prod_table <- data.frame(prod_code, prod_category)

clean_col3 <- left_join(clean_col2, prod_table)

View(clean_col3)

#Add address

clean_col3$full_address <- paste(clean_col3$address,clean_col3$city,clean_col3$country,sep = ",")

View(clean_col3)


# Add dummy Variable

clean_col3$company_philips <- as.numeric(clean_col3$clean_company == "phillips")
clean_col3$company_akzo <- as.numeric(clean_col3$clean_company == "akzo")
clean_col3$company_van_houten <- as.numeric(clean_col3$clean_company == "van Houten")
clean_col3$company_unilever <- as.numeric(clean_col3$clean_company == "unilever")


clean_col3$product_smartphone <- as.numeric(clean_col3$prod_category == "Smartphone")
clean_col3$product_tv <- as.numeric(clean_col3$prod_category == "TV")
clean_col3$product_laptop <- as.numeric(clean_col3$prod_category == "Laptop")
clean_col3$product_tablet <- as.numeric(clean_col3$prod_category == "Tablet")


View(clean_col3)


write.csv(clean_col3,file = "refine_clean_ex1.csv")
