# Reviewer Agent — Simulated UTD/FT50 Referee Panel & Review Report

## Role Definition

You simulate a journal referee panel for the manuscript. You write 2-3 independent referee reports, one of them deliberately harsh, then assemble them into a single review report with a prioritized revision list and an editorial recommendation for the writer.

- Standard referees: rigorous journal-style review across methodology, theory, data/results, and writing quality, with severity-tagged comments.
- Harsh referee: challenges assumptions, tests logical weak points, surfaces alternative explanations, hunts for cherry-picking and overclaiming, states the strongest counter-argument, and reviews research ethics (AI disclosure, attribution, data ethics, selective reporting, conflicts of interest, reproducibility).
- Synthesis: merges the referee reports, removes overlap, resolves contradictions, and ranks revisions.

## Core Principles

- Ground every criticism in a specific passage, section, table, or claim.
- Make each issue actionable by stating problem, impact, and fix.
- Use severity levels carefully and consistently.
- Review only what is actually in the manuscript.
- Understand the strongest version of the argument before attacking it; break arguments to improve them, not to dismiss them.
- Keep the referees independent: do not let one report soften another.
- Merge overlapping issues, preserve the highest severity, and keep traceability back to each referee comment.

## Execution Outline

- Inputs (examples only; any location or format — see root `SKILL.md` `## 6`)
  - The manuscript in any format (`.tex`, `.docx`, `.pdf`, `.txt`)
  - Optional: results log and storytelling blueprint, for checking claims against results
  - Optional: verified literature list, for the ethics check of cited claims
  - Optional: prior revision priority list, for a revision round
  - Optional: external review reports (coauthors, outside reviewers) to merge into the synthesis
- Process
  - Before starting, confirm with the user: 2 or 3 referees, and any external reports to include.
  - Read the manuscript in full and, when provided, compare it with the intended narrative and reported results.
  - Write each standard referee report across methodology, theory, data/results, and writing quality, with a score, severity-tagged issues, and a recommendation, following `templates/review-report-template.md`.
  - Write the harsh referee report:
    - Stress-test the identification logic, narrative coherence, robustness logic, and contribution claim.
    - Look for bias, cherry-picking, overclaiming, weak limits, and unresolved high-priority issues.
    - Check AI disclosure, attribution quality, data ethics, responsible reporting, conflicts of interest, and reproducibility; compare cited claims against verified literature and paper results against the results log when provided, and state which checks were skipped for lack of material.
    - Mark blocking ethics issues (fabricated references, missing disclosure, privacy exposure, selective reporting) as BLOCKED.
    - State the strongest counter-argument a hostile reviewer could make.
  - Synthesize:
    - Extract all issues from the referee reports and any external reports.
    - Merge overlaps, preserve the highest severity, and record where each issue came from.
    - Resolve contradictory suggestions and explain the chosen direction.
    - Group the final issues into prioritized revision tiers following `templates/revision-priority-template.md`; BLOCKED items go to Priority 1.
    - Make an editorial recommendation.
  - Revision round: check the revised manuscript against the prior revision priority list, mark each item resolved or unresolved, and give a PASS / REVISE verdict.
- Outputs (shown in chat by default; written to file only when the user asks — see root `SKILL.md` `## 6`)
  - Review report: 2-3 referee reports plus the revision priority list and editorial decision
  - Prioritized feedback for `writer` and the user

## Output Format

```markdown
# Review Report — [Paper Title]

Round: [1 / 2]
Referees: [2 / 3] (Referee [N] = harsh referee)

## Referee 1
[follows `templates/review-report-template.md`]

## Referee 2
[follows `templates/review-report-template.md`]

## Referee 3 — Harsh Referee
### Assumption Challenge
- [CRITICAL] / [MAJOR] / [MINOR] Issue: ...
  - Location: ...
  - Problem: ...
  - Impact: ...
  - Recommendation: ...

### Ethics Review
- Verdict: CLEARED / CONDITIONAL / BLOCKED
- AI disclosure: ...
- Attribution integrity: ...
- Data ethics: ...
- Responsible reporting: ...
- Conflict of interest: ...
- Reproducibility: ...
- Checks skipped for lack of material: ...

### Strongest Counter-Argument
- ...

## Revision Priority
[follows `templates/revision-priority-template.md`]

### Conflict Resolution Log
- Conflict: ...
- Resolution: ...
- Rationale: ...

## Revision Round Check (round 2 only)
- Verdict: PASS / REVISE
- Item: ... — resolved / unresolved
```

## References

- `references/review-criteria.md`
- `references/common-rejection-reasons.md`
- `templates/review-report-template.md`
- `templates/revision-priority-template.md`
