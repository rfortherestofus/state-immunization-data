# State Immunization Data

This repo has data on state-level immunization. 

The `data-raw` folder holds all raw data:

- `measles_cases.csv` has measles cases for each county. Data comes from the [Johns Hopkins U.S Measles Tracker](https://publichealth.jhu.edu/ivac/resources/us-measles-tracker)
- `mmr1_coverage.csv` presents data on the proportion of kindergarteners who received at least 1 dose of measles, mumps, and rubella (MMR) vaccine in the past school year. This data is available from the [CDC's SchoolVaxView website](https://www.cdc.gov/schoolvaxview/data/index.html)
- `dtap_coverage.csv` presents data on the proportion of 2-year-olds (24 months) who have received at least 4 doses of the DTaP vaccine. This data is available from the [CDC's ChildVaxView website](https://www.cdc.gov/childvaxview/about/interactive-reports.html)
- `non_medical_exemption_rates.csv` has non-medical exemption rates for each state. Data comes from the [CDC's SchoolVaxView website](https://www.cdc.gov/schoolvaxview/data/index.html)
- `non_medical_exemption_policies.csv` presents information on state policies regarding non-medical exemptions, such as those based on religious or personal beliefs. In some states, personal exemptions are also called “philosophical exemptions.” This data is available from the [National Conference of State Legislatures (NCSL) brief on 'State Non-Medical Exemptions From School Immunization Requirements'](https://www.ncsl.org/health/state-non-medical-exemptions-from-school-immunization-requirements). 
- `health_spending.csv` has public health spending for 2022-2023, available from ['America's health rankings'](https://www.americashealthrankings.org/explore/measures/PH_funding)
- `universal_purchase.csv` presents data on the 'Universal Vaccine Purchase Program', which is a state-led program in which the state government acquires all vaccines recommended by the Advisory Committee on Immunization Practices (ACIP) for every resident, regardless of their insurance coverage or ability to pay. Available from the [Association of Immunization Managers (AIM), Policy Maps – Universal Vaccine Purchase Program](https://www.immunizationmanagers.org/resources/aim-policy-maps/).
- `state_policies.csv` presents data on state policies that could affect childhood immunization. This dataset is derived from multiple sources, including the [Association of Immunization Managers, Legislative Round-ups](https://www.immunizationmanagers.org/resources-toolkits/immunization-program-policy-toolkit/legislative-round-ups/); keyword search on [LegiScan and NCSL's 'State Public Health Legislation Database'](https://www.ncsl.org/health/state-public-health-legislation-database)

We use the `data-raw/import-data.R` file to import and clean all of the above
files. The `data-raw/import-data.R` file then saves a set of clean CSV files into the `data-clean` folder. 

The CSV files in the `data-clean` folder are used to generate state-level immunization reports for all 50 states, the District of Columbia, and Puerto Rico. 
