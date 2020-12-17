# Search path
VPATH = data data-raw eda reports scripts

# Processed data files
DATA = meat_consumption.rds names.md

# EDA studies
EDA = meat_consumption.md names.md

# Reports
REPORTS = meat_consumption.md

# All targets
all : $(DATA) $(EDA) $(REPORTS)

# Data dependencies
meat_consumption.rds : meat_consumption.xlsx


# EDA study and report dependencies
meat_consumption.md : meat_consumption.rds

names.md : names.rds


# Pattern rules
%.rds : %.R
	Rscript $<
%.md : %.Rmd
	Rscript -e 'rmarkdown::render(input = "$<", output_options = list(html_preview = FALSE))'
