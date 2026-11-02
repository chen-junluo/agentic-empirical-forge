library(readr)
library(dplyr)
library(lfe)
library(texreg)

# ============================================================
# Starter paths
# ============================================================
project_root <- "/path/to/projects/<topic_slug>"
analysis_dir <- file.path(project_root, "analysis", "01_baseline_panel")

panel_path <- file.path(analysis_dir, "panel_baseline.csv")
tex_path <- file.path(analysis_dir, "tab_01_main.tex")

# panel_df <- read_csv(panel_path)

# ============================================================
# Starter baseline model
# ============================================================
# model_main <- felm(
#   market_value ~ hh_it_investment_proxy + emp + ppegt + xrd + firm_age |
#   gvkey + fyear | 0 | gvkey,
#   data = panel_df
# )
#
# texreg(
#   list(model_main),
#   file = tex_path,
#   stars = c(0.1, 0.05, 0.01, 0.001),
#   digits = 3,
#   booktabs = TRUE,
#   dcolumn = TRUE,
#   include.adjrs = FALSE,
#   include.rsquared = FALSE,
#   robust = TRUE
# )
