---
name: AEF04_writeup
description: "将分析结果和文献整合成完整的 LaTeX 论文草稿，并通过内部审查（模拟 peer review）迭代打磨。所有数字通过 \\input{} 引用 R 输出，只引用 VERIFIED 文献。写作→审查→修改循环最多 2 轮，达到可投稿质量。"
metadata:
  version: "1.0.0"
  last_updated: "2026-04-17"
  stage: "04"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# Stage 04: Write-up & Review — 论文写作与内部审查

将分析结果和文献整合成完整的 LaTeX 论文草稿，再通过模拟 peer review 迭代打磨。

## Objectives

- 产出结构完整、逻辑自洽的论文草稿
- 所有数字通过 `\input{}` 引用 R 输出，不手动填写
- 模拟 UTD/FT50 期刊 Reviewer 审查，发现并修复问题
- 写作→审查→修改循环最多 2 轮，达到可投稿质量

## Human-in-the-Loop Checkpoints

- 用户确认大纲（writeup/outline.md）后，Writer 才开始动笔
- 用户审阅草稿，提出修改意见
- 用户审阅审查报告，确认修改优先级
- 用户决定是否需要额外一轮审查（最多 2 轮）

## Orchestration Workflow

```
User confirms writeup/outline.md (from writeup/storytelling.md)
        │
        ▼
┌─────────────────────────┐
│  writer                 │
│  ① Read writeup/storytelling.md │
│  ② Read analysis output │
│  ③ Generate sections/   │
│  ④ Assemble main.tex    │
└───────────┬─────────────┘
            │
            ▼
      ★ User reviews draft
            │
            ▼
┌─────────────────────────┐
│  devils-advocate        │  ← Checkpoint 1: challenge assumptions
│  Challenge identification│    before formal review begins
│  Test narrative logic   │
│  Detect cherry-picking  │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────────────────────────────────┐
│  Parallel Review (3 agents run simultaneously)      │
│                                                     │
│  internal-reviewer    ethics-reviewer               │
│  Simulate 2-3         Data ethics                   │
│  reviewers            AI disclosure                 │
│  Score 4 dims         Selective reporting           │
│                                                     │
│  citation-compliance                                │
│  Verify \cite{} keys                                │
│  Check DOI completeness                             │
│  Auto-correct format errors                         │
└───────────────────────────┬─────────────────────────┘
                            │
                            ▼
            ┌─────────────────────────┐
            │  review-synthesizer     │
            │  Consolidate all 4      │
            │  review reports         │
            │  Produce priority list  │
            └───────────┬─────────────┘
                        │
                        ▼
              ★ User confirms revision priorities
                        │
                        ▼
            ┌─────────────────────────┐
            │  writer (revision)      │
            │  Apply priority fixes   │  ↺ max 2 rounds
            └───────────┬─────────────┘
                        │
                        ▼
            ┌─────────────────────────┐
            │  devils-advocate        │  ← Checkpoint 2: verify
            │  Verify revisions       │    revision quality before
            │  Final stress test      │    passing to Stage 05
            └───────────┬─────────────┘
                        │
                        ├── PASS ──▶ Stage 05 (exclusivity)
                        └── REVISE ──▶ Loop back to writer
```

## Agent Team (6 Agents)

| # | Agent | Role | Definition |
|---|-------|------|------------|
| 1 | `writer` | 学术写作专家：按章节生成 LaTeX 论文，严格引用 R 输出和 VERIFIED 文献 | `agents/writer.md` |
| 2 | `internal-reviewer` | 模拟 Reviewer：从方法论、理论、数据/结果、写作四个维度审查论文，产出逐条评审意见 | `agents/internal-reviewer.md` |
| 3 | `devils-advocate` | 假设挑战者：挑战识别策略假设、检测选择性报告偏差、压力测试核心论点 | `agents/devils-advocate.md` |
| 4 | `ethics-reviewer` | 研究伦理守门员：审查数据伦理、AI 披露、选择性报告、可重复性 | `agents/ethics-reviewer.md` |
| 5 | `citation-compliance` | 引用格式核查员：验证 `\cite{}` 与 `references.bib` 一致性，自动修正格式错误 | `agents/citation-compliance.md` |
| 6 | `review-synthesizer` | 审查综合员：汇总所有审查意见，生成修改优先级清单和 editorial decision | `agents/review-synthesizer.md` |

## References

| Reference | Purpose | Used By |
|-----------|---------|---------|
| `references/citation-rules.md` | Citation 验证硬性规则 | writer, citation-compliance |
| `references/review-criteria.md` | 审查维度与评分标准（方法论 30%、理论贡献 25%、数据/结果 25%、写作质量 20%） | internal-reviewer |
| `references/common-rejection-reasons.md` | UTD/FT50 期刊常见 desk reject 和 reject 原因汇总 | internal-reviewer, review-synthesizer, devils-advocate |

## Templates

| Template | Purpose |
|----------|---------|
| `templates/review-report-template.md` | 审查报告模板（含评分、逐条意见、修改建议） |
| `templates/revision-priority-template.md` | 修改优先级清单模板 |

---

## Input

- **`projects/<slug>/writeup/storytelling.md`**（AEF03_extend 产出的叙事蓝图，写作的核心依据）
- `projects/<slug>/analysis/tables/`
- `projects/<slug>/analysis/figures/`
- `projects/<slug>/analysis/results_log.md`
- `projects/<slug>/writeup/literature/literature_review.md`
- `projects/<slug>/writeup/outline.md`（用户确认后）
- `projects/<slug>/references.bib`

## Output

- `projects/<slug>/main.tex`
- `projects/<slug>/sections/`（按章节拆分）
- `projects/<slug>/review/internal_review_report.md`
- `projects/<slug>/review/devils_advocate_report.md`
- `projects/<slug>/review/ethics_review_report.md`
- `projects/<slug>/review/citation_audit_report.md`
- `projects/<slug>/review/revision_priority.md`

---

## Directory Structure

```
AEF04_writeup/
├── SKILL.md
├── agents/
│   ├── writer.md
│   ├── internal-reviewer.md
│   ├── devils-advocate.md
│   ├── ethics-reviewer.md
│   ├── citation-compliance.md
│   └── review-synthesizer.md
├── references/
│   ├── citation-rules.md
│   ├── review-criteria.md
│   └── common-rejection-reasons.md
└── templates/
    ├── review-report-template.md
    └── revision-priority-template.md
```

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-04-19 | First public v1.0.0 release |
