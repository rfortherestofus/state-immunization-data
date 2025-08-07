# Load Packages -----------------------------------------------------------

library(tidyverse)
library(janitor)
library(readr)
library(stringr)


# Measles -----------------------------------------------------------------

# CSV comes from https://publichealth.jhu.edu/ivac/resources/us-measles-tracker

# Import- measles cases dataset
measles_cases <- read_csv("data-raw/measles_cases.csv") |>
  clean_names() |>
  mutate(cases_total = as.numeric(cases_total)) |>
  drop_na(state, cases_total)

# Manual renaming if needed
if ("state" %in% names(measles_cases) == FALSE) {
  stop("'state' column missing.")
}
if ("cases_total" %in% names(measles_cases) == FALSE) {
  stop("'cases_total' column missing.")
}

# Total number of unique states
measles_cases %>%
  summarise(num_unique_states = n_distinct(state))

# Summarise by state
total_measles_cases <- measles_cases %>%
  group_by(state) %>%
  summarise(total_cases = sum(cases_total, na.rm = TRUE))

# Export data
write_csv(total_measles_cases, "data-clean/total_measles_cases.csv")


# MMR Coverage ------------------------------------------------------------
# CSV comes from CDC's SchoolVaxView (https://data.cdc.gov/Vaccinations/Vaccination-Coverage-and-Exemptions-among-Kinderga/ijqb-a7ye/about_data)
# Import- MMR coverage data
mmr_coverage <- read_csv("data-raw/mmr_coverage.csv") |>
  clean_names()

# Desired years
target_years <- c(
  "2020-21",
  "2021-22",
  "2022-23",
  "2023-24",
  "2024-25"
)
# Filter the data
mmr_filtered <- mmr_coverage %>%
  filter(
    vaccine_exemption == "MMR",
    school_year %in% target_years,
    (geography_type == "States" | geography == "United States")
  )
# Preview filtered data
head(mmr_filtered)

# Sort the dataset by descending years
mmr_filtered_sorted <- mmr_filtered %>%
  arrange(geography, school_year)

# Export the dataset
write_csv(mmr_filtered_sorted, "data-clean/mmr_coverage_final.csv")

# Non-medical exemption rate-----------------------------------------------------------------
# Data comes from CDC's SchoolVaxView (same dataset as above)
# Filter for non-medical exemptions for 2023-2024 and 2024-2025

non_medical_exemptions <- mmr_coverage %>%
  filter(
    dose == "Non-Medical Exemption",
    school_year %in% c("2023-24", "2024-25"),
    (geography_type == "States" | geography == "United States")
  )
# Export the dataset
write_csv(non_medical_exemptions, "data-clean/non_medical_exemption.csv")

# DTaP --------------------------------------------------------------------
# CSV comes from CDC's ChildVaxView (https://www.cdc.gov/childvaxview/about/interactive-reports.html)
# Import data set
dtap_coverage <- read_csv("data-raw/dtap_coverage.csv") |>
  clean_names()

# Filter
dtap_filtered_states <- dtap_coverage %>%
  filter(
    vaccine == "DTaP",
    dose == "≥4 Doses",
    dimension == "24 Months",
    birth_year_birth_cohort %in% c("2017", "2018", "2019", "2020", "2021")
  ) %>%
  arrange(geography, birth_year_birth_cohort)

# Export dataset
write_csv(dtap_filtered_states, "data-clean/dtap_coverage_final.csv")


# Vaccine Exemptions ------------------------------------------------------
# CSV from NCSL's brief (https://www.ncsl.org/health/state-non-medical-exemptions-from-school-immunization-requirements)

vaccine_exemptions <- read_csv("data-raw/non_medical_exemption_policies.csv")

# Export dataset
write_csv(
  vaccine_exemptions,
  "data-clean/non_medical_exemption_policies_final.csv"
)

# Health Spending ---------------------------------------------------------
# CSV from from 'America's health rankings'

# Import dataset-Public Health Spending
health_spending <- read_csv("data-raw/health_spending.csv")

# Export dataset
write_csv(health_spending, "data-clean/health_spending_final.csv")

# Universal vaccine purchase program------------------------------------------------------
# CSV from AIM resources page
universal_purchase <- read_csv("data-raw/universal_purchase.csv")

# Export dataset
write_csv(universal_purchase, "data-clean/universal_purchase_final.csv")

# State policies------------------------------------------------------
