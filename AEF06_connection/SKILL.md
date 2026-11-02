---
name: AEF06_connection
description: "先引导用户输入与 senior scholars 的所有 connection 痕迹，形成个人 Connection Document；再扫描某个 journal 某个 topic 的 potential SE/DE、AE、reviewer，并结合 connection 文档撰写 cover letter 和 submission protection strategy。当前版本将其视为 advanced workflow。"
metadata:
  version: "1.0.0"
  last_updated: "2026-04-17"
  stage: "06"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# Stage 06: Connection — 学术人脉、提名与 Cover Letter

先形成个人的 Connection Document，再针对某个 journal 某个 topic 扫描 potential SE/DE、AE、reviewer，最后结合 connection 与 nomination 文档撰写 cover letter，并提出给文章提供保护的建议。

## Objectives

- 当前版本定位：advanced workflow，用于投稿前策略准备
- 引导用户输入所有与 senior scholars 建立 connection 的活动与痕迹
- 输出个人化 Connection Document
- 扫描目标 journal 的 potential SE/DE、AE、reviewer，并给出 justification
- 输出专属于某个 journal 某个 topic 的 potential reviewer document
- 基于 Connection Document 和 potential reviewer document 撰写 cover letter
- 提出 submission protection strategy

## Human-in-the-Loop Checkpoints

- 用户补充和确认 Connection Document
- 用户审阅 potential reviewer document
- 用户确认 nomination / exclusion 方向
- 用户审阅 cover letter 与 protection notes

## Orchestration Workflow

```text
User provides academic activity history + target journal
        │
        ▼
┌──────────────────────────────┐
│ connection-mapper           │
│ ① 收集 connection 活动       │
│ ② 整理 scholar-level 关系    │
│ ③ 输出 connection document  │
└───────┬──────────────────────┘
        │
        ▼
  ★ User reviews and supplements connection document
        │
        ▼
┌──────────────────────────────┐
│ reviewer-scanner            │
│ ① 扫描 SE/DE, AE, reviewer   │
│ ② 给出 justification         │
│ ③ 输出 potential reviewers   │
└───────┬──────────────────────┘
        │
        ▼
  ★ User reviews nomination directions
        │
        ▼
┌──────────────────────────────┐
│ protective-cover-writer     │
│ ① 读取 connection + nominees │
│ ② 撰写 cover letter          │
│ ③ 给出 protection notes      │
└───────┬──────────────────────┘
        │
        ▼
  ★ User reviews cover letter and protection strategy
```

## Agent Team (3 Agents)

| # | Agent | Role | Definition |
|---|-------|------|------------|
| 1 | `connection-mapper` | Connection 文档构建员：引导用户输入所有 connection 活动，输出个人化 Connection Document | `agents/connection-mapper.md` |
| 2 | `reviewer-scanner` | 提名扫描员：扫描某个 journal 某个 topic 的 potential SE/DE、AE、reviewer，并给出 justification | `agents/reviewer-scanner.md` |
| 3 | `protective-cover-writer` | Cover Letter 与保护策略撰写员：基于 Connection Document 和 potential reviewer document 撰写 cover letter，并提出 submission protection strategy | `agents/protective-cover-writer.md` |

## References

| Reference | Purpose | Used By |
|-----------|---------|---------|
| `references/nomination-strategy.md` | nomination 策略指南 | reviewer-scanner |
| `references/cover-letter-guide.md` | cover letter 写作规范 | protective-cover-writer |

## Templates

| Template | Purpose |
|----------|---------|
| `templates/connection-file-template.md` | Connection Document 模板 |
| `templates/nomination-report-template.md` | potential reviewer document 模板 |
| `templates/cover-letter-template.md` | cover letter 模板 |

## Input

- `projects/<slug>/main.tex`
- `projects/<slug>/strategy/target_journal.md`
- 用户提供的 connection 活动与 scholar 接触记录
- `projects/<slug>/strategy/exclusivity_document.md`（如有）

## Output

- `projects/<slug>/strategy/connection_document.md`
- `projects/<slug>/strategy/potential_reviewers.md`
- `projects/<slug>/strategy/cover_letter.md`
- `projects/<slug>/strategy/submission_protection_notes.md`

## Directory Structure

```text
AEF06_connection/
├── SKILL.md
├── agents/
│   ├── connection-mapper.md
│   ├── reviewer-scanner.md
│   └── protective-cover-writer.md
├── references/
│   ├── nomination-strategy.md
│   └── cover-letter-guide.md
└── templates/
    ├── connection-file-template.md
    ├── nomination-report-template.md
    └── cover-letter-template.md
```

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-04-19 | First public v1.0.0 release |
