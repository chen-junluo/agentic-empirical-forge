# Proposal

## Working title
IT Investment, Digital Capability, and Firm Resilience in the S&P 1500

## Research question
Do firms with stronger IT investment proxies exhibit stronger resilience in firm outcomes during periods of elevated uncertainty?

## Data backbone
This project combines three source families documented in `data/DATA_DESCRIPTION.md`:
- Harte-Hanks for IT infrastructure and IT investment proxy fields
- BoardEx for executive and board characteristics
- Compustat for firm-year accounting and scale controls

The post-link panel is organized at the firm-year level using `gvkey` and `fyear`.

## Why this design is promising
- the data structure supports a firm-year panel design
- the project can connect technology investment fields to governance and accounting fields
- the merged panel can support both baseline models and later heterogeneity analysis

## What must be resolved before identify
- exact definition of `[hh_it_investment_proxy]`
- exact rule for S&P 1500 membership
- exact outcome field for the first baseline model
- final merge-loss audit across Harte-Hanks, BoardEx, and Compustat
