# read in meat file and make it tidy

# Author: Callan Hoskins
# Version: 2020-01-26

# Libraries
library(tidyverse)
library(readxl)

# Parameters
raw_data <- here::here("data-raw/meat_consumption.xlsx")
export_path <- here::here("data/meat_consumption.rds")

turkey_col_names <-
  c(
    "year",
    "qtr",
    "prod_fed_inspected",
    "prod_condemnation",
    "prod_ready_to_cook",
    "na_col",
    "prod_beginning_stocks",
    "prod_imports",
    "prod_total_supply",
    "prod_exports",
    "prod_ending_stocks",
    "prod_total_disapp",
    "prod_us_pop",
    "per_cap_carcass_wt",
    "per_cap_retail_wt",
    "per_cap_retail_wt_boneless"
  )

beef_col_names <-
  c(
    "year",
    "qtr",
    "prod_commercial",
    "prod_farm",
    "prod_total",
    "na_col",
    "prod_beginning_stocks",
    "prod_imports",
    "prod_total_supply",
    "prod_exports",
    "prod_ending_stocks",
    "prod_total_disapp",
    "prod_us_pop",
    "per_cap_carcass_wt",
    "per_cap_retail_wt",
    "na_col_2",
    "per_cap_retail_wt_boneless"
  )

red_meat_col_names <-
  c(
    "year",
    "qtr",
    "prod_commercial",
    "prod_farm",
    "prod_total",
    "na_col",
    "prod_beginning_stocks",
    "prod_imports",
    "prod_total_supply",
    "prod_exports",
    "prod_ending_stocks",
    "prod_total_disapp",
    "prod_us_pop",
    "per_cap_carcass_wt",
    "per_cap_retail_wt",
    "per_cap_retail_wt_boneless"
  )

poultry_col_names <-
  c(
    "year",
    "qtr",
    "prod_fed_inspected",
    "prod_condemnation",
    "prod_ready_to_cook",
    "na_col",
    "prod_beginning_stocks",
    "prod_imports",
    "prod_total_supply",
    "prod_exports",
    "prod_ending_stocks",
    "prod_total_disapp",
    "prod_us_pop",
    "per_cap_carcass_wt",
    "per_cap_retail_wt",
    "per_cap_retail_wt_boneless"
  )

pork_col_names <-
  c(
    "year",
    "qtr",
    "prod_commercial",
    "prod_farm",
    "prod_total",
    "na_col",
    "prod_beginning_stocks",
    "prod_imports",
    "prod_total_supply",
    "prod_exports",
    "prod_ending_stocks",
    "prod_total_disapp",
    "prod_us_pop",
    "per_cap_carcass_wt",
    "per_cap_retail_wt",
    "per_cap_retail_wt_boneless"
  )

broiler_col_names <-
  c(
    "year",
    "qtr",
    "prod_fed_inspected",
    "prod_condemnation",
    "prod_ready_to_cook",
    "na_col",
    "prod_beginning_stocks",
    "prod_imports",
    "prod_total_supply",
    "prod_exports",
    "prod_ending_stocks",
    "prod_total_disapp",
    "prod_us_pop",
    "per_cap_carcass_wt",
    "per_cap_retail_wt",
    "per_cap_retail_wt_boneless"
  )

# ============================================================================

# Code

turkey <-
  readxl::read_excel(
    raw_data,
    sheet = "WASDE_Turkey-Full",
    skip = 3,
    col_names = turkey_col_names
  ) %>%
  fill(year) %>%
  filter(qtr == "Yr Jan-Dec") %>%
  select(-c(qtr, na_col)) %>%
  mutate(meat = "Turkey")

beef <-
  readxl::read_excel(
    raw_data,
    sheet = "WASDE_Beef-Full",
    skip = 3,
    col_names = beef_col_names
  ) %>%
  fill(year) %>%
  filter(qtr == "Yr Jan-Dec") %>%
  select(-c(qtr, na_col, na_col_2)) %>%
  mutate(meat = "Beef")

red_meat <-
  readxl::read_excel(
    raw_data,
    sheet = "WASDE_TotalRedMeat-Full",
    skip = 3,
    col_names = red_meat_col_names
  ) %>%
  fill(year) %>%
  filter(qtr == "Yr Jan-Dec") %>%
  select(-c(qtr, na_col)) %>%
  mutate(meat = "Red Meat")

poultry <-
  readxl::read_excel(
    raw_data,
    sheet = "WASDE_TotalPoultry-Full",
    skip = 3,
    col_names = poultry_col_names
  ) %>%
  fill(year) %>%
  filter(qtr == "Yr Jan-Dec") %>%
  select(-c(qtr, na_col)) %>%
  mutate(meat = "Poultry")

pork <-
  readxl::read_excel(
    raw_data,
    sheet = "WASDE_Pork-Full",
    skip = 3,
    col_names = pork_col_names
  ) %>%
  fill(year) %>%
  filter(qtr == "Yr Jan-Dec") %>%
  select(-c(qtr, na_col)) %>%
  mutate(meat = "Pork")

broiler <-
  readxl::read_excel(
    raw_data,
    sheet = "WASDE_Broiler-Full",
    skip = 3,
    col_names = broiler_col_names
  ) %>%
  fill(year) %>%
  filter(qtr == "Yr Jan-Dec") %>%
  select(-c(qtr, na_col)) %>%
  mutate(meat = "Chicken")

other_chicken <-
  readxl::read_excel(
    raw_data,
    sheet = "WASDE_OtherChicken-Full",
    skip = 3,
    col_names = pork_col_names
  ) %>%
  fill(year) %>%
  filter(qtr == "Yr Jan-Dec") %>%
  select(-c(qtr, na_col)) %>%
  mutate(meat = "Chicken")

lamb_mutton <-
  readxl::read_excel(
    raw_data,
    sheet = "WASDE_LambMutton-Full",
    skip = 3,
    col_names = pork_col_names
  ) %>%
  fill(year) %>%
  filter(qtr == "Yr Jan-Dec") %>%
  select(-c(qtr, na_col)) %>%
  mutate(meat = "Lamb/Mutton")

veal <-
  readxl::read_excel(
    raw_data,
    sheet = "WASDE_Veal-Full",
    skip = 3,
    col_names = pork_col_names
  ) %>%
  fill(year) %>%
  filter(qtr == "Yr Jan-Dec") %>%
  select(-c(qtr, na_col)) %>%
  mutate(meat = "Veal")

turkey %>%
  bind_rows(
    pork,
    poultry,
    beef,
    red_meat,
    broiler,
    other_chicken,
    lamb_mutton,
    veal
  ) %>%
  group_by(year, meat) %>%
  summarize_at(
    vars(per_cap_carcass_wt, per_cap_retail_wt, per_cap_retail_wt_boneless),
    sum,
    na.rm = TRUE
  ) %>%
  ungroup() %>%
  mutate(year = as.integer(year)) %>%
  write_rds(export_path)






