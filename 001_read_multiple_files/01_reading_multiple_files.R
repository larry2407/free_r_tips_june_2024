# R TIPS ----
# TIP 001: Reading Multiple Files ----
#
# 👉 For Weekly R-Tips, Signup Here: https://learn.business-science.io/r-tips-newsletter

library(tidyverse) # data manipulation
library(fs) # file system

file_paths <- fs::dir_ls("001_read_multiple_files/data")
file_paths

# 1.0 FOR LOOP ----

file_contents <- list() # Initialize list

for (i in seq_along(file_paths)) {
    file_contents[[i]] <- read_csv(
        file = file_paths[[i]]
    )
}

# paths are too long to name elements of a list
#How to rename each element of the list with shorter names?
file_names <- str_split(file_paths, "/") %>%
    # map_chr(~ .x[length(.x)]) %>% # Get last element
    map_chr(last) %>% # Get last element)
    str_remove(".csv") # Remove .csv


file_contents <- set_names(file_contents, file_names)# Set names to list

list2env(file_contents, envir = .GlobalEnv) # Assign to Global Environment


# 2.0 PURRR MAP ----

file_contents_2 <- file_paths %>%
    map(function (path) {
        read_csv(path)
    }) %>% set_names(file_names)

# sames mapping as file_contents_2 but using the anonymous function notation
file_contents_3 <- file_paths %>%
    map(\(x) read_csv(x)) %>% set_names(file_names)

# same as above using lapply
file_contents_4 <- lapply(file_paths, read_csv) %>% set_names(file_names)

# str(file_contents[[1]]) %>% identical(str(file_contents_2[[1]]))
# str(file_contents_2)
# LEARNING MORE ----

# FREE MASTERCLASS
# - 10 SECRETS TO BECOMING A DATA SCIENTIST
#   https://learn.business-science.io/free-rtrack-masterclass

# where are the apps currently accessing my github https://github.com/settings/applications
