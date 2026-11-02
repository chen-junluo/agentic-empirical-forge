# Storytelling

**Paper:** IT Investment, Digital Capability, and Firm Resilience in the S&P 1500
**Status:** starter extend-stage artifact

---

## 1. Main finding

**One-line claim**
- Starter target claim: firms with stronger IT investment proxies appear more resilient in firm outcomes, but the exact narrative depends on the first clean baseline model.

**Main regression anchor**
- Candidate DV: `[market_value]` or `sale`
- Key field: `[hh_it_investment_proxy]`
- Baseline controls: `emp`, `ppegt`, `xrd`, `sic`, `[firm_age]`
- Panel key: `gvkey` × `fyear`
- Expected script folder: `analysis/01_baseline_panel/`
- Expected baseline table: first main-results table to be produced in identify

**Starter interpretation**
- The paper should first establish that the IT investment proxy is not just a descriptive technology footprint, but a field that maps into economically meaningful firm outcomes.

---

## 2. Credibility support

| Check | Why it matters | Starter direction |
|------|----------------|------------------|
| Merge audit | confirms the usable sample is not driven by arbitrary linkage loss | document retention from Harte-Hanks, BoardEx, and Compustat |
| Missingness audit | clarifies whether the baseline fields are broadly usable | inspect `xrd`, governance fields, and IT fields |
| Outcome substitution | tests whether the story depends on one narrow DV | compare `[market_value]` with `sale` or related operating fields |
| Industry exclusion sensitivity | checks whether industry composition drives the pattern | keep financial-firm exclusion stable and test broader industry group sensitivity |

**Starter summary**
- The first extend-stage credibility work should focus on data structure, merge quality, and outcome substitution before more ambitious identification claims are made.

---

## 3. Mechanism

| Mechanism | Field logic | Starter direction |
|----------|-------------|------------------|
| Coordination capacity | richer IT infrastructure may improve internal coordination under stress | examine whether infrastructure-heavy firms retain operating scale better |
| Governance complementarity | IT value may be stronger when boards or executives understand digital systems | interact `[hh_it_investment_proxy]` with `[board_it_experience_proxy]` |
| Technology depth | simple presence of systems may differ from deeper IT intensity | compare broad IT proxy with more granular Harte-Hanks infrastructure fields |

**Starter summary**
- The mechanism section should remain field-driven: which source fields plausibly capture coordination, governance complementarity, or IT depth.

---

## 4. Heterogeneity

| Dimension | Field or split | Starter direction |
|----------|----------------|------------------|
| Board IT experience | `[board_it_experience_proxy]` | stronger effect when governance is more digitally informed |
| Firm size | `at` or `[market_value]` split | larger firms may benefit differently from IT scale |
| Industry information intensity | industry grouping derived from `sic` | information-intensive sectors may show stronger IT payoff |

**Starter summary**
- The first heterogeneity tests should come from fields already documented in `DATA_DESCRIPTION.md`, not from speculative new constructs.

---

## 5. Contribution story

1. **Data foundation:** the project links Harte-Hanks, BoardEx, and Compustat into a firm-year panel.
2. **Core empirical move:** it tests whether an IT investment proxy is associated with better firm outcomes.
3. **Why the result is plausible:** the source fields support a story about coordination, governance complementarity, and technology depth.
4. **Why extend matters:** robustness, heterogeneity, and mechanism should all stay anchored to documented fields and mergeable data sources.

---

## 6. Results not yet in the story

| Analysis | Status | Reason |
|---------|--------|--------|
| Shock interaction design | pending | uncertainty field not finalized |
| Stronger causal identification | pending | baseline field construction comes first |
| Fine-grained Harte-Hanks module analysis | pending | exact vendor field names still placeholders |
