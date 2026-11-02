# Idea Candidates

## Idea A: IT investment and firm resilience in the S&P 1500

### Research question
Does stronger IT investment predict stronger resilience in firm outcomes for S&P 1500 firms?

### Data match
- IT fields come from Harte-Hanks placeholders such as `[hh_it_investment_proxy]`, `[hh_pc_count]`, and `[hh_server_count]`
- governance complements can be constructed from BoardEx fields such as `[digital_or_it_experience_flag]`, `[tenure]`, and `[independence_flag]`
- financial outcomes and controls can be drawn from Compustat fields such as `at`, `sale`, `emp`, `ppegt`, `xrd`, `ceq`, `csho`, and `prcc_f`
- the linked panel uses `gvkey` and `fyear`

### Feasibility
High as a starter panel project, conditional on a credible Harte-Hanks linkage and a stable definition of the IT proxy.

### Main risks
- Harte-Hanks field definitions are still placeholders in the starter
- merge attrition may be non-trivial
- the first outcome definition must be narrowed before identify

## Idea B: IT investment and governance complementarity

### Research question
Is the effect of IT investment stronger when firms also have stronger board-level digital or IT experience?

### Data match
- IT fields from Harte-Hanks
- governance heterogeneity from BoardEx
- outcomes and controls from Compustat

### Feasibility
Reasonable as a second-pass extension once the baseline IT proxy is stabilized.

## Idea C: IT investment and valuation retention under uncertainty

### Research question
Do firms with stronger IT investment proxies retain market value better during uncertainty episodes?

### Data match
- valuation outcome can be built from `prcc_f` and `csho`
- controls and firm characteristics come from Compustat
- IT proxy comes from Harte-Hanks starter fields

### Feasibility
Good if a usable uncertainty or shock field is added later.
