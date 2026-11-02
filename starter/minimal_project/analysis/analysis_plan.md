# Analysis Plan

## Data backbone
- Main linked firm identifier: `gvkey`
- Main time identifier: `fyear`
- Core panel structure: S&P 1500 firm-year panel, excluding financial firms
- Main source for financial fields: Compustat annual fundamentals
- Governance source: BoardEx
- IT source: Harte-Hanks Computer Intelligence

## Fields to operationalize first
- Main explanatory field: `[hh_it_investment_proxy]`
- Candidate outcomes: `[market_value]`, `sale`, `at`
- Core controls: `emp`, `ppegt`, `xrd`, `sic`, `[firm_age]`
- Governance complement field: `[board_it_experience_proxy]`

## Immediate identify-stage tasks
1. finalize Harte-Hanks to `gvkey` matching workflow
2. define the exact construction of `[hh_it_investment_proxy]`
3. construct `[market_value] = prcc_f × csho`
4. confirm industry exclusions using `sic`
5. produce descriptive statistics for `at`, `sale`, `emp`, `ppegt`, `xrd`
6. document missingness and sample loss by merge step

## Baseline model skeleton
- Outcome_it = β1 × `[hh_it_investment_proxy]`_it + controls_it + firm FE + year FE
- Extension model = baseline + shock interaction once a shock field is finalized

## Output expectation
- one cleaned baseline panel
- one descriptive summary table
- one baseline regression table
- updated `results_log.md`
