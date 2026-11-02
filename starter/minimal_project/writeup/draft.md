# Draft

## Title
IT Investment, Digital Capability, and Firm Resilience in the S&P 1500

## Positioning paragraph
This starter draft treats IT investment as a firm capability that may matter most when firms face coordination strain or uncertainty. Rather than beginning with a broad claim about technology and performance, the paper begins with a narrower empirical question: whether a firm-year panel that links Harte-Hanks, BoardEx, and Compustat can show that stronger IT-related fields are associated with stronger firm outcomes.

## Introduction notes
Firms invest in information technology for many reasons, but one of the most important may be resilience. If digital infrastructure improves coordination, information processing, and operational adaptability, then the value of IT investment should become more visible when firms face stress rather than only during normal periods. This project builds a linked firm-year panel to test that possibility using Harte-Hanks technology fields, BoardEx governance fields, and Compustat accounting data.

The first objective is deliberately modest. Before making strong causal claims, the project needs to establish that the linked panel is usable, that the main IT proxy can be defined credibly, and that the resulting field structure supports a stable baseline association with firm outcomes. That is why the early writeup is organized around data construction, merge quality, and baseline directional evidence.

## Data section notes
The merged panel is organized around `gvkey` and `fyear`. Harte-Hanks contributes the main IT-side fields, including the starter placeholders `[hh_it_investment_proxy]`, `[hh_pc_count]`, and `[hh_server_count]`. BoardEx contributes person-firm governance fields that can later be collapsed into firm-year measures such as `[board_it_experience_proxy]`. Compustat contributes the accounting and scale backbone, including `at`, `sale`, `emp`, `ppegt`, `xrd`, `ceq`, `csho`, and `prcc_f`.

At the starter stage, the key empirical challenge is not only model selection but field construction. The Harte-Hanks linkage must be documented carefully, BoardEx role records must be collapsed consistently, and the baseline sample must make clear how much attrition occurs at each merge step.

## Baseline design notes
The first-pass model should estimate the association between `[hh_it_investment_proxy]` and a firm outcome such as `[market_value]` or `sale`, controlling for firm scale and investment-related fields. A sensible starter control set begins with `emp`, `ppegt`, `xrd`, `sic`, and `[firm_age]`, with firm and year fixed effects added once the panel is stable.

This initial model should be interpreted as a baseline directional test. If the sign and magnitude are plausible, the project can then move into extend-stage work that asks whether the pattern survives alternative outcomes, governance-based heterogeneity, and more granular Harte-Hanks field definitions.

## Results notes
The first reported result should do three things. First, it should show that the IT proxy is measurable in a non-trivial subset of the linked sample. Second, it should establish whether the baseline coefficient is directionally consistent with the resilience story. Third, it should indicate whether the effect size is large enough to justify further extend-stage work.

Even at the draft stage, the writeup should distinguish clearly between what comes directly from documented fields and what remains to be built. For example, `[market_value]` can be anchored to `prcc_f × csho`, while governance complements can be tied back to BoardEx-derived measures. By contrast, a stronger uncertainty design still requires an additional shock field that is not yet finalized.

## Discussion notes
If the baseline association holds, the contribution of the project is not simply that IT matters. The more specific claim is that firm-level IT fields may encode a resilience capability that becomes visible in how firms preserve outcomes under pressure. That interpretation becomes stronger when it can be connected to governance complementarity and technology depth rather than to a single undifferentiated IT measure.

## Current writeup status
- This draft is a starter writeup artifact, not a finished paper section.
- All reported empirical claims are placeholders until linked tables are produced.
- The next writeup step is to convert these notes into section files tied to actual results and citations.
