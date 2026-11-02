# Results Log

## 2026-03-29 — 01_baseline_panel / sample assembly
- Model: sample assembly and merge audit
- DV: none
- Key IV: `[hh_it_investment_proxy]` availability
- Coefficient: not applicable
- SE: not applicable
- Significance: not applicable
- N: starter placeholder
- FE / Cluster: not applicable
- Interpretation: the first identify-stage priority is not estimation but building a usable firm-year panel around `gvkey` and `fyear`
- Data notes: expected sample loss will come mainly from Harte-Hanks linkage and BoardEx role collapsing
- Next step: finalize a merge-complete baseline sample and record merge retention by source

## 2026-03-29 — 01_baseline_panel / descriptive scan
- Model: descriptive scan before regression
- DV: `[market_value]`, `sale`, `at`
- Key IV: `[hh_it_investment_proxy]`
- Coefficient: not estimated yet
- SE: not estimated yet
- Significance: not estimated yet
- N: starter placeholder
- FE / Cluster: year summaries only at this stage
- Interpretation: before any causal or panel specification, the project needs a clean view of scale, dispersion, missingness, and overlap across the IT and accounting fields
- Data notes: check missingness for `xrd`, sparse coverage for Harte-Hanks fields, and whether BoardEx-based governance measures are available across the target sample
- Next step: produce a baseline descriptive table for the matched sample

## 2026-03-29 — 01_baseline_panel / baseline model skeleton
- Model: firm-year panel baseline
- DV: candidate first-pass outcome = `[market_value]`
- Key IV: `[hh_it_investment_proxy]`
- Coefficient: starter placeholder
- SE: starter placeholder
- Significance: starter placeholder
- N: starter placeholder
- FE / Cluster: firm FE + year FE; clustered SE to be decided after panel structure is confirmed
- Interpretation: the first baseline model should establish whether the IT proxy is directionally associated with firm-level outcomes before moving to extend-stage robustness and mechanism work
- Data notes: baseline controls should start with `emp`, `ppegt`, `xrd`, `sic`, and `[firm_age]`
- Next step: decide whether `[market_value]`, `sale`, or another field should be the first reporting outcome

## Status tags to use later
- `WORK`: result is usable in the main story
- `MARGINAL`: result may be kept for discussion but not central
- `NOT WORK`: result stays on record but should not drive the writeup
