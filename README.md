# State Immunization Data

This repo has data on state-level immunization. 

The `data-raw` folder holds all raw data:

- `measles_cases.csv` has measles cases for each county. Data comes from TODO.

We use the `data-raw/import-data.R` file to import and clean all of the above
files. The `data-raw/import-data.R` file then saves a a set of clean CSV files
into the `data-clean` folder. 

The CSV files in the `data-clean` folder are used to generate state-level immunization reports.