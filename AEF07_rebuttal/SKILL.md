---
name: AEF07_rebuttal
description: "审稿回复工具箱：零遗漏拆分 decision letter 与 reviewer comments、逐条制定回应方案、撰写完整 response letter（editor 部分简洁整合、reviewer 部分点对点）、润色已有 response letter、检查 manuscript / response letter / appendix 的一致性。五个 agent 均可单独调用。"
metadata:
  version: "1.1.0"
  last_updated: "2026-11-02"
  stage: "07"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# AEF07_rebuttal：审稿回复与修订

- 用法：按用户意图从 agent menu 选一个 agent，Read `agents/<name>.md` 执行；不需要从第一个 agent 开始
- 典型顺序：`comment-decomposer` → `response-planner` →（需要改论文时回到 `AEF02_identify`–`AEF04_writeup`；用户写 reviewer 逐条回复）→ `response-letter-writer` → `response-polisher` → `consistency-checker`
- Input / Output：menu 里的 input 只是来源示例；输入格式不限，输出默认在对话中给出，用户要求时才保存，保存位置由用户指定（见根 `SKILL.md` `## 6`）

---
## 1. Agent menu

- `comment-decomposer`：把审稿意见零遗漏拆成编号 comment units（`SE-1`、`AE-1`、`R1-1`…），写一行 diagnosis，对无需实质修改的直接起草回复
  - 何时用：刚收到 decision letter / reviewer comments
  - Input：reviewer comments、decision letter，或用户直接粘贴；可选 manuscript
  - Output：response letter skeleton
  - Rules：`references/revision-best-practices.md`、`templates/response-letter-template.md`、`<AEF_ROOT>/shared/writing-principles.md`
  - ★ 停下：用户确认拆分完整、分组合理
- `response-planner`：逐条提出可迭代的回应方案，不明确处与用户多轮讨论
  - 何时用：已有编号 comments，需要决定每条怎么回、要不要改论文
  - Input：response letter skeleton；可选 manuscript、期刊定制材料（如 Exclusivity Document）、当前 sections / tables、用户对已做修改的说明
  - Output：response strategy、revision tracking
  - Rules：`references/response-strategy.md`、`references/revision-best-practices.md`、`templates/response-letter-template.md`、`templates/revision-tracking-template.md`、`<AEF_ROOT>/shared/writing-principles.md`
  - ★ 停下：用户逐条讨论不明确的 comment，并确认回应方案
- `response-letter-writer`：撰写完整 response letter；SE / DE / AE 部分写简洁的整合回复（具体感谢 + 最多 3 个标注 `(integrated from RX-Y)` 的努力点 + 修改位置），reviewer 部分按用户的逐条回复点对点成文
  - 何时用：回应方案已确认，reviewer 逐条回复已有草稿或要点，需要成文完整 letter
  - Input：editor 与 reviewer comments（response letter skeleton、decision letter、reviewer comments 或粘贴）、用户对 reviewer comments 的逐条回复（草稿、要点或 `.docx`）；可选 response strategy、revision tracking、manuscript
  - Output：response letter、response letter notes；`.docx` 仅在用户认可后生成
  - Rules：`references/response-letter-guide.md`、`references/response-polishing-guide.md`、`templates/response-letter-template.md`、`references/response-letter-docx-format.md`（生成 `.docx` 时）、`<AEF_ROOT>/shared/writing-principles.md`
  - ★ 停下：用户审阅 letter，并确认 notes 中无回复的 reviewer 点、无对应的 editor concern、缺失的修改位置、超过 3 点时的取舍
- `response-polisher`：只润色已有 response letter 的语言（称呼、立场、语气、结构），不改实质内容，逐点核对 comment 覆盖
  - 何时用：已有 response letter 草稿；不从零起草
  - Input：response letter（`.docx` 或 Markdown）、reviewer comments（原文或 response letter skeleton；letter 已完整引用时可省）
  - Output：polished response letter、polishing notes；`.docx` 仅在用户认可后生成
  - Rules：`references/response-polishing-guide.md`、`references/response-letter-docx-format.md`（生成或修改 `.docx` 时）、`<AEF_ROOT>/shared/writing-principles.md`
  - ★ 停下：用户审阅润色稿、未回应的点和需确认项
- `consistency-checker`：单文件或跨文件检查 sample size、术语、cross-reference、承诺兑现；只报告不改文件
  - 何时用：重新投稿前，或用户给出任意文件要求查一致性
  - Input：manuscript / response letter / appendix 任意组合（通常 `.docx`）；可选 reviewer comments、revision tracking
  - Output：consistency report
  - Rules：`references/consistency-checklist.md`、`references/revision-best-practices.md`
  - ★ 停下：用户逐条确认 `Needs user confirmation` 项

---
## 2. Files

- `references/` 是用户维护的规则文件，新增规则直接改对应文件（见根 `SKILL.md` `## 5. Rule capture`）
- 本 stage 全部文件：`references/response-strategy.md`、`references/revision-best-practices.md`、`references/response-letter-guide.md`、`references/consistency-checklist.md`、`references/response-polishing-guide.md`、`references/response-letter-docx-format.md`、`templates/response-letter-template.md`、`templates/revision-tracking-template.md`
