# Search path
VPATH = data data-raw eda reports scripts

# Processed data files
DATA = meat_consumption.rds names.md vaccines.rds world_populations.rds

# EDA studies
EDA = meat_consumption.md names.md vaccines.md

# Reports
REPORTS = meat_consumption.md names.md

# All targets
all : $(DATA) $(EDA) $(REPORTS)

# Data dependencies
meat_consumption.rds : meat_consumption.xlsx
vaccines.rds : vaccines.csv
un_hdi_2019.rds : un_hdi_2019.xlsx
world_populations.rds : world_populations.csv


# EDA study and report dependencies
meat_consumption.md : meat_consumption.rds

names.md : names.rds

vaccines.md : vaccines.rds un_hdi_2019.rds world_populations.rds


# Pattern rules
%.rds : %.R
	Rscript $<
%.md : %.Rmd
	Rscript -e 'rmarkdown::render(input = "$<", output_options = list(html_preview = FALSE))'
