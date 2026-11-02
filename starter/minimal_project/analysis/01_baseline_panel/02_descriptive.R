library(readr)
library(dplyr)
library(texreg)

# ============================================================
# Starter paths
# ============================================================
project_root <- "/path/to/projects/<topic_slug>"
analysis_dir <- file.path(project_root, "analysis", "01_baseline_panel")
table_dir <- analysis_dir

panel_path <- file.path(analysis_dir, "panel_baseline.csv")

# panel_df <- read_csv(panel_path)

# ============================================================
# Example descriptive fields
# ============================================================
# fields <- c("hh_it_investment_proxy", "market_value", "sale", "at", "emp", "ppegt", "xrd")
# summary_df <- panel_df %>%
#   summarise(across(all_of(fields), list(mean = mean, sd = sd), na.rm = TRUE))

# write_csv(summary_df, file.path(analysis_dir, "descriptive_summary.csv"))
