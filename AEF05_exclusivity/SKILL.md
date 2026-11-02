---
name: AEF05_exclusivity
description: "先读取或检索目标期刊的大批量文献，提炼该 journal 特有的 exclusivity 文档，再基于该文档对 manuscript 做针对性修改。当前版本将其视为 advanced workflow。"
metadata:
  version: "1.0.0"
  last_updated: "2026-04-17"
  stage: "05"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# Stage 05: Exclusivity — 期刊定制与行文排他性

针对目标期刊的大批量文献，总结该 journal 的叙事方式、section 排布、偏好与排斥项，再基于该 exclusivity 文档对 manuscript 做定向修改。

## Objectives

- 当前版本定位：advanced workflow，用于主路径草稿之后的期刊定制
- 处理用户提供或自行检索的大批量 journal 文献
- 总结某个 journal 的叙事方式、写作风格、section 排布与偏好
- 输出可迭代更新的 Exclusivity Document
- 基于 Exclusivity Document 对 manuscript 做具体修改建议与改写

## Human-in-the-Loop Checkpoints

- 用户指定目标 journal
- 用户确认 exclusivity corpus 是否合适
- 用户审阅 Exclusivity Document
- 用户确认 manuscript 修改方向

## Orchestration Workflow

```text
User specifies target journal + provides papers or asks for retrieval
        │
        ▼
┌──────────────────────────────┐
│ journal-exclusivity-profiler │
│ ① 处理大批量 journal 文献      │
│ ② 总结叙事与结构偏好           │
│ ③ 输出 exclusivity document   │
└───────┬──────────────────────┘
        │
        ▼
  ★ User reviews exclusivity document
        │
        ▼
┌──────────────────────────────┐
│ exclusivity-rewriter         │
│ ① 对照 exclusivity document  │
│ ② 定向修改 manuscript        │
│ ③ 输出 revision notes        │
└───────┬──────────────────────┘
        │
        ▼
  ★ User confirms manuscript adaptation direction
```

## Agent Team (2 Agents)

| # | Agent | Role | Definition |
|---|-------|------|------------|
| 1 | `journal-exclusivity-profiler` | 期刊排他性提炼员：处理大批量 journal 文献，总结叙事、结构、风格和偏好，输出可迭代 Exclusivity Document | `agents/journal-exclusivity-profiler.md` |
| 2 | `exclusivity-rewriter` | 排他性改写员：基于 Exclusivity Document 对 manuscript 做定向修改与 revision notes | `agents/exclusivity-rewriter.md` |

## Templates

| Template | Purpose |
|----------|---------|
| `templates/journal-profile-template.md` | 新期刊档案模板 |
| `templates/journal-fit-report-template.md` | Exclusivity / fit 文档模板参考 |

## Input

- `projects/<slug>/main.tex`
- `projects/<slug>/strategy/target_journal.md`
- 用户提供的 journal papers，或用户要求检索的 journal corpus

## Output

- `projects/<slug>/strategy/exclusivity_document.md`
- `projects/<slug>/strategy/exclusivity_revision_notes.md`
- 修改后的 manuscript（用户确认后）

## Directory Structure

```text
AEF05_exclusivity/
├── SKILL.md
├── agents/
│   ├── journal-exclusivity-profiler.md
│   └── exclusivity-rewriter.md
└── templates/
    ├── journal-profile-template.md
    └── journal-fit-report-template.md
```

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-04-19 | First public v1.0.0 release |
