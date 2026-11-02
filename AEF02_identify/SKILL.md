---
name: AEF02_identify
description: "基于选定的 idea，完成 identify 阶段的基础实证分析（数据清洗、描述性统计、主回归），产出 preliminary results。确认结果方向后进入 AEF03_extend。"
metadata:
  version: "1.0.0"
  last_updated: "2026-04-17"
  stage: "02"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# Stage 02: identify — 基础实证分析

基于选定的 idea，完成 identify 阶段的基础实证分析（数据清洗、描述性统计、主回归），产出 preliminary results。确认结果方向后再进入 AEF03_extend。

## Objectives

- 数据清洗与描述性统计
- 主回归（至少一个可汇报的结果）
- 确认结果方向，决定是否继续

## Human-in-the-Loop Checkpoints

- 用户确认分析方案（做哪些回归，用什么识别策略）
- 用户审查 preliminary results，决定是否继续

## Orchestration Workflow

```
User confirms idea (from Stage 01)
        │
        ▼
┌───────────────────┐
│  data-analyst     │
│  ① deps.R         │
│  ② 01_clean.R     │
│  ③ 02_descriptive │
└───────┬───────────┘
        │
        ▼
  ★ User reviews descriptive stats
        │
        ▼
┌───────────────────┐
│  data-analyst     │
│  ④ 03_main.R      │
│  ⑤ results_log.md │
└───────┬───────────┘
        │
        ▼
  ★ User reviews preliminary results
        │
        ├── Results worth extending ──▶ Stage 03 (extend)
        └── Results weak ──▶ Revise analysis plan / pivot
```

## Agent Team (1 Agent)

| # | Agent | Role | Definition |
|---|-------|------|------------|
| 1 | `data-analyst` | 计量经济学分析师：编写并执行 R 脚本，输出可直接引用的 LaTeX 表格和图表 | `agents/data-analyst.md` |

## References

| Reference | Purpose | Used By |
|-----------|---------|---------|
| `references/r-conventions.md` | R 脚本规范（包管理、回归、输出格式） | data-analyst |
| `references/analysis-dimensions.md` | 分析维度与调参规范（DV/IV 形态、FE 化、Binning、聚类 SE） | data-analyst |

## Input

- `projects/<slug>/data/raw/`（原始数据）
- `projects/<slug>/analysis/analysis_plan.md`（用户确认后）

## Output

- `projects/<slug>/analysis/scripts/deps.R`
- `projects/<slug>/analysis/scripts/01_clean.R`
- `projects/<slug>/analysis/scripts/02_descriptive.R`
- `projects/<slug>/analysis/scripts/03_main.R`
- `projects/<slug>/analysis/tables/tab_01_descriptive.tex`
- `projects/<slug>/analysis/tables/tab_02_main.tex`
- `projects/<slug>/analysis/results_log.md`

## Directory Structure

```text
AEF02_identify/
├── SKILL.md
├── agents/
│   └── data-analyst.md
├── references/
│   ├── r-conventions.md
│   └── analysis-dimensions.md
└── templates/
```

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-04-19 | First public v1.0.0 release |
