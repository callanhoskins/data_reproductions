# Collects all names data and aggregates to one tibble
# Reads in Excel files with names data downloaded from the ONS for England and
# Wales:
# https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/livebirths/datasets/babynamesenglandandwalesbabynamesstatisticsgirls

# Author: Callan Hoskins
# Version: 2020-01-26

# Libraries
library(tidyverse)
library(readxl)

# Parameters
output_path <- here::here("data/names.rds")

# ============================================================================

# Reads named Excel files
# The files are not consistent from year to year so special rules must be
# made for specific series of years
read_names <- function(year, gender) {
  destfile <- str_glue(here::here("data-raw/names_{year}_{gender}s.xls"))
  sheet <- 4
  if (year > 1996 && year < 2011) {
    sheet <- 7
  } else if (year >= 2011) {
    sheet <- 9
  }
  if (year > 2018) {
    destfile <- str_c(destfile, "x")
  }
  if (year <= 2016) {
    destfile %>%
      str_glue() %>%
      read_excel(
        sheet = sheet,
      ) %>%
      transmute(
        rank = as.integer(...2),
        name = as.character(...3) %>% str_to_title(),
        count = as.double(...4),
        gender = gender,
        year = year
      ) %>%
      drop_na(rank)
  } else {
    destfile %>%
      str_glue() %>%
      read_excel(sheet = sheet) %>%
      transmute(
        rank = as.integer(Contents),
        name = as.character(...2) %>% str_to_title(),
        count = as.double(...3),
        gender = gender,
        year = year
      ) %>%
      drop_na(rank)
  }
}

boys <-
  seq(1996, 2019) %>%
  map(read_names, gender = "boy") %>%
  bind_rows()

girls <-
  seq(1996, 2019) %>%
  map(read_names, gender = "girl") %>%
  bind_rows()

boys %>%
  bind_rows(girls) %>%
  write_rds(output_path)
