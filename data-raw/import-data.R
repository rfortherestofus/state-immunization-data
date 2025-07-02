
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(janitor)


# Measles -----------------------------------------------------------------

# CSV comes from cdc.gov/measles

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
  summarise(total_cases = sum(cases_total))

# Export data
write_csv(total_measles_cases, "data/total_measles_cases.csv")



# MMR Coverage ------------------------------------------------------------

#Import- MMR coverage data
mmr_coverage <- read_csv(
  "~/Library/CloudStorage/OneDrive-SharedLibraries-JohnsHopkins/Rose Weeks - Monitoring State Immunization Policies/Indicators/Raw data files/Vaccination_Coverage_and_Exemptions_among_Kindergartners_20250528.csv"
)
names(mmr_coverage)

# Clean column names
mmr_coverage <- janitor::clean_names(mmr_coverage)

# Desired years
target_years <- c(
  "2019-20",
  "2020-21",
  "2021-22",
  "2022-23",
  "2023-24"
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
#Export the dataset
library(readr)
write_csv(mmr_filtered_sorted, "MMR coverage.csv")

#Extract the non medical exemption rate from this data set
library(dplyr)
install.packages("stringr")
library(stringr)

# Filter for non-medical exemptions for 2022-2023 and 2023-2024
unique(mmr_coverage$dose)
non_medical_exemptions <- mmr_coverage %>%
  filter(
    dose == "Non-Medical Exemption",
    school_year %in% c("2022-23", "2023-24"),
    (geography_type == "States" | geography == "United States")
  ) %>%
  arrange(school_year, geography)
#Export the dataset
write_csv(non_medical_exemptions, "Non-medical exemption rates.csv")

# DTaP --------------------------------------------------------------------


dtap_coverage <- read_csv(
  "~/Library/CloudStorage/OneDrive-SharedLibraries-JohnsHopkins/Rose Weeks - Monitoring State Immunization Policies/Indicators/Raw data files/Vaccination_Coverage_among_Young_Children__0-35_Months__20250528.csv"
)
View(dtap_coverage)
#Clean column names
dtap_coverage <- janitor::clean_names(dtap_coverage)
names(dtap_coverage)
# Filter
dtap_filtered_states <- dtap_coverage %>%
  filter(
    vaccine == "DTaP",
    dose == "≥4 Doses",
    dimension == "24 Months",
    birth_year_birth_cohort %in% c("2017", "2018", "2019", "2020", "2021")
  ) %>%
  arrange(geography, birth_year_birth_cohort)
print(dtap_filtered_states)
#Export dataset
write_csv(dtap_filtered_states, "DTaP coverage rates.csv")


# Vaccine Exemptions ------------------------------------------------------

vaccine_exemptions <- read_csv(
  "~/Library/CloudStorage/OneDrive-SharedLibraries-JohnsHopkins/Rose Weeks - Monitoring State Immunization Policies/Indicators/Raw data files/State_vaccine_exemptions_0528.csv"
)
View(vaccine_exemptions)
names(vaccine_exemptions)


# Health Spending ---------------------------------------------------------

#Import dataset-Public Health Spending
install.packages("readr")
library(readr)
library(readr)
health_spending <- read_csv(
  "~/Library/CloudStorage/OneDrive-SharedLibraries-JohnsHopkins/Rose Weeks - Monitoring State Immunization Policies/Indicators/Raw data files/Public Health Spending_America's Health Rankings.csv"
)
View(health_spending)


# Anti-Vaccination Groups -------------------------------------------------

# Data comes from Lexis-Nexis
# We did XXXX
