library(readr)
library(dplyr)
library(janitor)

# ============================================================
# Starter paths
# ============================================================
project_root <- "/path/to/projects/<topic_slug>"
data_dir <- file.path(project_root, "data", "raw")
analysis_dir <- file.path(project_root, "analysis", "01_baseline_panel")

# ============================================================
# Placeholder inputs
# ============================================================
# Replace these with real files after data extraction.
compustat_path <- file.path(data_dir, "compustat_annual.csv")
boardex_path <- file.path(data_dir, "boardex_firm_year.csv")
hh_path <- file.path(data_dir, "harte_hanks.csv")

# Example read pattern
# compustat <- read_csv(compustat_path) %>% clean_names()
# boardex <- read_csv(boardex_path) %>% clean_names()
# harte_hanks <- read_csv(hh_path) %>% clean_names()

# ============================================================
# Starter panel construction notes
# ============================================================
# 1. use gvkey and fyear as the baseline firm-year keys
# 2. standardize Harte-Hanks firm identifiers before matching
# 3. collapse BoardEx role records to firm-year governance measures
# 4. exclude financial firms using sic
# 5. save the baseline panel after merge diagnostics

# Placeholder write pattern
# write_csv(panel_df, file.path(analysis_dir, "panel_baseline.csv"))
