---
name: AEF04_writeup
description: "论文写作与内审工具箱：按 storytelling 蓝图撰写 / 修订论文（默认 LaTeX，可出 Word；不编造数字、只引用 VERIFIED 文献；综述与 citation 检查转给 AEF01_explore 的 literature-reviewer）、模拟 UTD/FT50 referee panel 产出 2–3 份 referee comments（其中一份刻意苛刻，含假设挑战与伦理审查）并组装成附 revision priority 的 review report。两个 agent 均可单独调用。"
metadata:
  version: "1.1.0"
  last_updated: "2026-11-02"
  stage: "04"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# AEF04_writeup：论文写作与内部审查

- 用法：按用户意图从 agent menu 选一个 agent，Read `agents/<name>.md` 执行；不需要从第一个 agent 开始
- 典型顺序：`writer` → `reviewer` → `writer`（修订）→ `reviewer`（第 2 轮核对修订）
- Input / Output：menu 里的 input 只是来源示例；输入格式不限，输出默认在对话中给出，用户要求时才保存，保存位置由用户指定（见根 `SKILL.md` `## 6`）
- manuscript 正文必须写文件：`writer` 写入前先列出要新建 / 修改的文件，用户确认后再写

---
## 1. Agent menu

- `writer`：只负责写作；以 storytelling 为骨架逐章节撰写 LaTeX 论文并组装 `main.tex`；修订轮按 revision priority 修改；需要写综述或 check citation 时转给 `AEF01_explore` 的 `literature-reviewer`
  - 何时用：已有 storytelling 蓝图，需要写初稿；或已有 review report，需要修订
  - Input：storytelling 蓝图、outline（没有时先在对话中提出）、表格与图、已验证文献（如 `references.bib`）；修订轮加 review report 中的 revision priority 或用户给的审查意见
  - Output：manuscript（默认 LaTeX，用户要求时出 `.docx`；修订轮在 LaTeX 文件末尾追加 `%% === Revision Round N ===` 注释）；不确定的数字留 `[[NUM: 说明]]`，确定的数字注明来源脚本与表格
  - Rules：`<AEF_ROOT>/shared/citation-rules.md`、`<AEF_ROOT>/shared/writing-principles.md`
  - ★ 停下：动笔前用户确认 outline 与要写入的文件清单；完成后用户审阅草稿
- `reviewer`：模拟期刊 referee panel，产出 2–3 份独立 referee comments，其中一份刻意苛刻（假设挑战、cherry-picking 与 overclaiming、最强反驳论点、伦理审查：AI 披露、attribution、数据伦理、选择性报告、利益冲突、可复现性，可判 BLOCKED）；最后组装成一份附 revision priority 与 editorial decision 的 review report；修订轮核对上一轮 revision priority 并给出 PASS / REVISE
  - 何时用：需要模拟 peer review、投稿前内审，或核对修订是否到位
  - Input：manuscript（`.tex`、`.docx`、`.pdf`、`.txt` 均可）；可选 results log、storytelling 蓝图、已验证文献清单、上一轮 revision priority、外部 / 合作者审查意见
  - Output：review report（2–3 份 referee comments + revision priority + editorial decision）
  - Rules：`references/review-criteria.md`、`references/common-rejection-reasons.md`、`templates/review-report-template.md`、`templates/revision-priority-template.md`
  - ★ 停下：开始前用户确认 referee 数量（2 或 3）与要并入的外部意见；完成后用户确认 revision priority；第 2 轮后用户决定是否继续

---
## 2. Stage 规则

- 审查循环（用户要求完整内审时使用）：
  - `writer` 写稿 → `reviewer` 出 review report → 用户确认 revision priority → `writer` 修订 → `reviewer` 第 2 轮核对
  - 第 2 轮为 REVISE 时回到 `writer`；整个循环最多 2 轮，每轮由用户确认修改优先级
- 综述与 citation 检查（存在性、claim 与 abstract 一致性、reference 格式）不在本 stage 做，统一转给 `AEF01_explore` 的 `literature-reviewer`

---
## 3. Files

- `references/` 是用户维护的规则文件，新增规则直接改对应文件（见根 `SKILL.md` `## 5. Rule capture`）；citation 规则统一维护在 `<AEF_ROOT>/shared/citation-rules.md`
- 本 stage 全部文件：`references/review-criteria.md`、`references/common-rejection-reasons.md`、`templates/review-report-template.md`、`templates/revision-priority-template.md`
- 未被 agent 引用：`templates/conference_paper_template.md`、`templates/latex_article_template.tex`
