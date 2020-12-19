# Reads in data on world populations, tidies it, and writes it to .rds file

# Author: Callan Hoskins
# Version: 2020-01-26

# Libraries
library(tidyverse)

# Parameters
pop_path <- here::here("data-raw/world_populations.csv")
output_path <- here::here("data/world_populations.rds")

# ============================================================================

# Code
read_csv(pop_path, skip = 4) %>%
  select(country = `Country Name`, `1960`:`2019`) %>%
  pivot_longer(cols = `1960`:`2019`, names_to = "year", values_to = "pop") %>%
  mutate(
    year = year %>% as.integer(),
    country = if_else(country == "Korea, Rep.", "South Korea", country)
  ) %>%
  write_rds(output_path)
