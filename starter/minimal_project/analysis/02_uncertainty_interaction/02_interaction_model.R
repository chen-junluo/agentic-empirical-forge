library(readr)
library(dplyr)
library(lfe)
library(texreg)

# ============================================================
# Starter paths
# ============================================================
project_root <- "/path/to/projects/<topic_slug>"
analysis_dir <- file.path(project_root, "analysis", "02_uncertainty_interaction")
input_panel <- file.path(analysis_dir, "panel_with_shock.csv")
tex_path <- file.path(analysis_dir, "tab_02_uncertainty_interaction.tex")

# panel_df <- read_csv(input_panel)

# ============================================================
# Starter interaction model
# ============================================================
# model_interaction <- felm(
#   market_value ~ hh_it_investment_proxy * shock_period + emp + ppegt + xrd + firm_age |
#   gvkey + fyear | 0 | gvkey,
#   data = panel_df
# )
#
# texreg(
#   list(model_interaction),
#   file = tex_path,
#   stars = c(0.1, 0.05, 0.01, 0.001),
#   digits = 3,
#   booktabs = TRUE,
#   dcolumn = TRUE,
#   include.adjrs = FALSE,
#   include.rsquared = FALSE,
#   robust = TRUE
# )
