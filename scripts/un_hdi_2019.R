# Reads in 2019 HDI data from the UN and writes it to RDS

# Author: Callan Hoskins
# Version: 2020-01-26

# Libraries
library(tidyverse)
library(readxl)

# Parameters
hdi_path <- here::here("data-raw/un_hdi_2019.xlsx")
output_path <- here::here("data/un_hdi_2019.rds")

col_names <-
  c(
    "country_rank" = "...1",
    "country" = "...2",
    "hdi_val" = "Human Development Index (HDI)",
    "life_exp_at_birth" = "Life expectancy at birth",
    "exp_yrs_school" = "Expected years of schooling",
    "gni_per_cap" = "Gross national income (GNI) per capita",
    "gni_per_cap_minus_hdi_rank" = "GNI per capita rank minus HDI rank"
  )

# Code

read_excel(hdi_path, skip = 4) %>%
  select(!!! col_names) %>%
  mutate(
    country_rank = country_rank %>% as.integer(),
    hdi_val = hdi_val %>% as.double(),
    life_exp_at_birth = life_exp_at_birth %>% as.double(),
    exp_yrs_school = exp_yrs_school %>% as.double(),
    gni_per_cap = gni_per_cap %>% as.double(),
    gni_per_cap_minus_hdi_rank = gni_per_cap_minus_hdi_rank %>% as.integer()
  ) %>%
  drop_na(country_rank) %>%
  mutate(
    country =
      case_when(
        country == "Korea (Republic of)" ~ "South Korea",
        TRUE ~ country
      )
  ) %>%
  write_rds(output_path)
