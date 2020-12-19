# Reads in vaccines agreement data and writes modified data to .rds file

# Author: Callan Hoskins
# Version: 2020-01-26

# Libraries
library(tidyverse)

# Parameters
data_path <- here::here("data-raw/vaccines.csv")
output_path <- here::here("data/vaccines.rds")

#===============================================================================

# Code
data_path %>%
  read_csv(
    col_names = c("country", "august", "october"),
    skip = 1
  ) %>%
  arrange(desc(october)) %>%
  pivot_longer(
    cols = c("august", "october"),
    names_to = "month",
    values_to = "perc_agree"
  ) %>%
  mutate(month = month %>% str_to_title() %>% str_c(" 2020")) %>%
  write_rds(output_path)
