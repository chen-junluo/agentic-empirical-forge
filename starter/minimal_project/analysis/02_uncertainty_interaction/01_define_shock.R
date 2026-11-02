library(readr)
library(dplyr)

# ============================================================
# Starter paths
# ============================================================
project_root <- "/path/to/projects/<topic_slug>"
analysis_dir <- file.path(project_root, "analysis", "02_uncertainty_interaction")
input_panel <- file.path(project_root, "analysis", "01_baseline_panel", "panel_baseline.csv")

# panel_df <- read_csv(input_panel)

# ============================================================
# Starter uncertainty field
# ============================================================
# Replace this placeholder with a real uncertainty or shock definition.
# panel_df <- panel_df %>%
#   mutate(shock_period = ifelse(fyear %in% c(2015, 2016), 1, 0))
#
# write_csv(panel_df, file.path(analysis_dir, "panel_with_shock.csv"))
