---
name: AEF07_rebuttal
description: "处理期刊审稿意见：先把 decision letter 与 reviewer comments 零遗漏拆分成 response-letter-ready comment units，再为每个 comment 制定可迭代的初版回应方案。遇到不明确之处，不擅自假设，而是与用户多轮讨论后再形成最终修改方案。当前版本将其视为 advanced workflow。"
metadata:
  version: "1.0.0"
  last_updated: "2026-04-17"
  stage: "07"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# Stage 07: Rebuttal — 审稿回复与修订

处理期刊审稿意见，先把 decision letter、AE report 和 reviewer comments 严格拆成零遗漏的 comment units，再为每条 comment 形成可迭代的回应方案与修改路径。

## Objectives

- 当前版本定位：advanced workflow，仅在收到审稿意见后使用
- 将连续 prose 形式的 review material 零遗漏拆分为独立 comment units
- 为每条 comment 生成 sharp diagnosis 与待完成 response skeleton
- 对无需 substantive revision 的 comment 直接生成 formal response draft
- 为每条 comment 提出可迭代的初版回应方案
- 对不明确之处与用户多轮讨论，而不是擅自假设
- 最终形成可执行的 response strategy 与 revision tracking
- 对已有 response letter 做语言层面的润色（称呼、语气、段落结构），不做实质性更改
- 在重新投稿前，对 manuscript、response letter、appendix 做单文件或跨文件的一致性检查

## Human-in-the-Loop Checkpoints

- 用户粘贴 decision letter、AE report 和 reviewer comments
- 用户确认 comment decomposition 结果是否准确、完整
- 用户逐条讨论不明确或需要策略判断的 comment
- 用户确认 response strategy 与 revision tracking
- 用户审阅最终 Response Letter 草稿
- 用户审阅润色后的 response letter 与 polishing notes（尤其是未回应的点和需要确认的项）
- 用户逐条确认 consistency report 中的问题（尤其是标记为 `Needs user confirmation` 的项）

## Orchestration Workflow

```text
User pastes decision letter + reviewer comments
        │
        ▼
┌──────────────────────────────┐
│  comment-decomposer          │
│  ① 零遗漏拆分 comments       │
│  ② smart merge 非实质性内容   │
│  ③ 编号（SE/AE/R1/...）      │
│  ④ 写一行 diagnosis          │
│  ⑤ 对无需修改项直接起草回复    │
└───────┬──────────────────────┘
        │
        ▼
  ★ User checks decomposition completeness and grouping
        │
        ▼
┌──────────────────────────────┐
│  response-planner            │
│  ① 逐条提出初版回应方案       │
│  ② 标出需要补问的地方         │
│  ③ 与用户多轮讨论             │
│  ④ 输出 strategy + tracking  │
└───────┬──────────────────────┘
        │
        ▼
  ★ User confirms revision plan and response strategy
        │
        ├── 需要论文修改 ──▶ Route to Stage 02-04 agents
        │
        ▼
┌──────────────────────────────┐
│  response-polisher           │
│  ① 只润色语言，不改实质内容    │
│  ② 称呼 / 立场 / 语气 / 结构  │
│  ③ 逐点核对 comment 覆盖      │
│  ④ 输出 polished + notes     │
└───────┬──────────────────────┘
        │
        ▼
  ★ User reviews polished letter and uncovered points
        │
        ▼
┌──────────────────────────────┐
│  consistency-checker         │
│  ① 单文件 / 跨文件模式        │
│  ② 按 consistency-checklist  │
│     逐项检查                  │
│  ③ 输出 consistency report   │
└───────┬──────────────────────┘
        │
        ▼
  ★ User reviews consistency issues and fixes
        │
        └── Response Letter 定稿 ──▶ [提交修订]
```

`consistency-checker` 也可单独触发：用户只提供一个或多个文件（manuscript / response letter / appendix）要求查一致性时，直接运行，无需先走前两个 agent。

`response-polisher` 也可单独触发：用户提供一份已有的 response letter 要求润色时，直接运行。它只润色 existing response letter，不从零起草。

## Agent Team (4 Agents)

| # | Agent | Role | Definition |
|---|-------|------|------------|
| 1 | `comment-decomposer` | 审稿意见拆分员：对 decision letter 与 reviewer comments 做零遗漏拆分、编号、diagnosis，并为无需 substantive revision 的内容直接生成 formal response | `agents/comment-decomposer.md` |
| 2 | `response-planner` | 回复方案规划员：逐条给出可迭代的初版回应方案，对不明确之处与用户讨论，最终形成 response strategy 与 revision tracking | `agents/response-planner.md` |
| 3 | `consistency-checker` | 一致性检查员：以单文件或跨文件模式检查 manuscript、response letter、appendix 的 sample size、术语、cross-reference、承诺与内容一致性；只报告不改文件 | `agents/consistency-checker.md` |
| 4 | `response-polisher` | 回复润色员：对已有 response letter 做语言层面的润色（称呼、立场、语气、段落结构），不做实质性更改；逐点核对 comment 覆盖并提醒未回应之处 | `agents/response-polisher.md` |

## References

| Reference | Purpose | Used By |
|-----------|---------|---------|
| `references/response-strategy.md` | 审稿回复策略规范 | response-planner |
| `references/revision-best-practices.md` | R&R 修订最佳实践 | comment-decomposer, response-planner, consistency-checker |
| `references/consistency-checklist.md` | 一致性检查项清单（唯一来源，新增检查项直接改此文件） | consistency-checker |
| `references/response-polishing-guide.md` | Response letter 称呼、立场、语气、结构要求（新增要求直接改此文件） | response-polisher |
| `<AEF_ROOT>/shared/writing-principles.md` | 全局通用英文写作原则（no em-dashes、AI 词汇等） | response-polisher |

## Templates

| Template | Purpose |
|----------|---------|
| `templates/response-letter-template.md` | Response Letter 模板 |
| `templates/revision-tracking-template.md` | 修订追踪表模板 |

## Input

- `projects/<slug>/review/reviewer_comments.md`（用户粘贴）
- `projects/<slug>/review/decision_letter.md`（如有）
- `projects/<slug>/main.tex`（当前版本，可选）
- `projects/<slug>/strategy/journal_fit_report.md`（可选）
- 修订后的 manuscript、response letter、appendix（通常为 `.docx`，consistency-checker 使用）
- 已有的 response letter（`.docx` 或 `review/response_letter.md`，response-polisher 使用）

## Output

- `projects/<slug>/review/response_letter_skeleton.md`（comment-decomposer 产出）
- `projects/<slug>/review/response_strategy.md`（response-planner 产出）
- `projects/<slug>/review/revision_tracking.md`（response-planner 产出）
- `projects/<slug>/review/response_letter.md`（后续整合与定稿）
- `projects/<slug>/review/response_letter_polished.md`、`projects/<slug>/review/polishing_notes.md`（response-polisher 产出）
- `projects/<slug>/review/consistency_report.md`（consistency-checker 产出）

## Directory Structure

```text
AEF07_rebuttal/
├── SKILL.md
├── agents/
│   ├── comment-decomposer.md
│   ├── response-planner.md
│   ├── consistency-checker.md
│   └── response-polisher.md
├── references/
│   ├── response-strategy.md
│   ├── revision-best-practices.md
│   ├── consistency-checklist.md
│   └── response-polishing-guide.md
└── templates/
    ├── response-letter-template.md
    └── revision-tracking-template.md
```

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-04-19 | First public v1.0.0 release |
