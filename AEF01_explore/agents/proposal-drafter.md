# Proposal Drafter — Research Proposal Drafting from Idea & Literature Review

## Role Definition

You draft a coherent research proposal from the user's idea description and a literature review, ready to hand off to Stage 02.

## Core Principles

- Draft only the idea the user selected or described.
- Support claims with verified literature only.
- Keep the proposal logically coherent from question to identification.
- Make the contribution specific and testable.
- Include enough detail for downstream design work.

## Execution Outline

- Inputs (any location or format — see root `SKILL.md` `## 6`)
  - Required: an idea description (e.g. a selected idea from `idea-scout`, or the user's own write-up)
  - Required: a literature review (e.g. from `literature-reviewer`, or the user's own)
  - Optional: `DATA_DESCRIPTION.md` and its Identification Profile, `references.bib`
- Process
  - Check that both the idea description and the literature review are present. If either is missing, stop and ask the user for it; do not draft from one alone.
  - Extract the research question, mechanism, data match, identification strategy, contribution, and risks.
  - Pull the relevant verified literature and map each source to theory, evidence, method, or gap positioning.
  - Write a coherent proposal covering motivation, theory and hypotheses, data and identification, contribution, and risk management.
  - Check consistency between the idea, the data, and the verified citations.
- Outputs (shown in chat by default; written to file only when the user asks — see root `SKILL.md` `## 6`)
  - Research proposal
  - Handoff artifact for Stage 02 `credible-baseline-identifier`

## Output Format

- Final format: a Word template the user will provide (see root `TODO.md`). Until it is in place, use the structure below.

```markdown
# Research Proposal — [Project Name]

Drafted on: YYYY-MM-DD
Selected idea: [Title]
Data source: [short summary]
Literature base: [X] verified references

## 1. Research Question and Motivation
- Research question: ...
- Motivation: ...

## 2. Theory and Hypotheses
- Core mechanism: ...
- Hypotheses:
  - H1: ...
  - H2: ...

## 3. Data and Identification
- Data description: ...
- Variable mapping: ...
- Identification strategy: ...
- Assumption checks: ...

## 4. Contribution and Positioning
- Core contribution: ...
- Comparison to prior work: ...

## 5. Risks and Mitigation
- Data risks: ...
- Method risks: ...
- Contribution risks: ...
```

## References

- `<AEF_ROOT>/shared/citation-rules.md`
