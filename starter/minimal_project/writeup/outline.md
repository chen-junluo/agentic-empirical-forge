# Outline

## 1. Introduction
- Motivate why IT investment should be studied as a resilience-enabling capability rather than only a productivity input.
- State the core research question using the documented field backbone: can `[hh_it_investment_proxy]` explain stronger firm outcomes in a `gvkey` × `fyear` panel?
- Preview the three-source data structure: Harte-Hanks, BoardEx, and Compustat.

## 2. Data and field construction
- Describe the firm-year panel and the post-link keys `gvkey` and `fyear`.
- Explain how Harte-Hanks fields are used to construct `[hh_it_investment_proxy]`.
- Explain how BoardEx fields support governance complements such as `[board_it_experience_proxy]`.
- Explain how Compustat fields supply outcomes and controls such as `at`, `sale`, `emp`, `ppegt`, `xrd`, `ceq`, `csho`, and `prcc_f`.
- Document sample exclusions, especially financial firms.

## 3. Baseline empirical design
- Present the first-pass panel specification.
- Explain why the initial writeup should focus on field construction, merge quality, and directional evidence before stronger causal claims.
- Define the first outcome to be reported, likely `[market_value]` or `sale`.

## 4. Main results
- Report the baseline association between `[hh_it_investment_proxy]` and the first chosen firm outcome.
- Explain magnitude in economic terms once the table is available.
- Clarify what the baseline result does and does not establish.

## 5. Credibility checks
- Merge audit and sample retention.
- Missingness audit for `xrd`, governance fields, and Harte-Hanks fields.
- Outcome substitution across `[market_value]`, `sale`, and related firm outcomes.
- Industry sensitivity around the non-financial sample.

## 6. Mechanism and heterogeneity
- Governance complementarity through `[board_it_experience_proxy]`.
- Technology depth through more granular Harte-Hanks infrastructure fields.
- Heterogeneity by firm size and industry information intensity.

## 7. Discussion and contribution
- Explain why the project contributes by linking IT-related fields to resilience rather than only average performance.
- Distinguish what is already established from what still requires extend-stage work.
- Note the dependence of stronger claims on better Harte-Hanks field resolution and cleaner shock definitions.

## 8. Limitations and next steps
- Harte-Hanks field names are still starter placeholders.
- Merge attrition may affect representativeness.
- Stronger identification requires an additional uncertainty or shock field.
- The next stage should convert the baseline outline into section-level draft text and tables.
