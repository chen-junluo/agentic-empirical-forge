# Handoff Schemas — Cross-Stage Data Contracts

## Purpose

Defines the exact data structure for every artifact passed between pipeline stages.
All agents that produce or consume these artifacts MUST conform to these schemas.
Consuming agents should validate input and request re-generation if schema violations are found.

> **Convention**: All schemas use Markdown-based structured output. Agents MUST validate required fields before accepting a handoff. Missing required fields trigger a `HANDOFF_INCOMPLETE` failure path.

---

## Schema 1: Idea Candidates (AEF01_explore → AEF02_identify)

**Producer**: `AEF01_explore/idea-scout` + `AEF01_explore/lit-sentinel`
**Consumer**: `AEF02_identify/data-analyst`

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `selected_idea` | object | 用户选定的 idea（含研究问题、机制、数据匹配） |
| `research_question` | string | 一句话研究问题（X 如何影响 Y，在什么情境下） |
| `identification_strategy` | string | 因果识别策略（DID / IV / RDD / FE / matching） |
| `data_match` | object | `{available_vars: list[string], missing_vars: list[string], dv: string, iv: string, controls: list[string]}` |
| `anchor_literature` | list[Reference] | ≥3 篇 VERIFIED 锚点文献 |
| `feasibility_scores` | object | `{data_availability: 1-5, method_feasibility: 1-5, contribution_potential: 1-5}` |

### Reference Object

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `author` | string | Yes | Author(s) |
| `year` | integer | Yes | Publication year |
| `title` | string | Yes | Paper title |
| `journal` | string | Yes | Journal name |
| `doi` | string | Yes | DOI |
| `verification_status` | enum | Yes | `VERIFIED` / `VERIFIED via URL` |
| `core_finding` | string | Yes | 核心发现（1-2 句话） |
| `relevance` | string | Yes | 与本研究的关联 |

### Artifacts

| File | Producer | Consumer |
|------|----------|----------|
| `writeup/ideas/idea_candidates.md` | idea-scout | User (选择), data-analyst (读取选定 idea) |
| `writeup/literature/literature_review.md` | lit-sentinel | writer (Stage 04), lit-sentinel (Stage 04 扩展) |
| `references.bib` | lit-sentinel | writer (Stage 04) |

---

## Schema 2: Preliminary Results (AEF02_identify → AEF03_extend)

**Producer**: `AEF02_identify/data-analyst`
**Consumer**: `AEF03_extend/data-analyst`

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `main_regression` | object | 主回归结果摘要 |
| `result_direction` | enum | `positive` / `negative` / `mixed` / `null` |
| `significance` | string | 显著性水平和关键系数 |
| `sample_size` | integer | 最终分析样本量 |
| `data_quality_notes` | list[string] | 数据清洗中发现的问题 |

### Artifacts

| File | Producer | Consumer |
|------|----------|----------|
| `analysis/scripts/deps.R` | data-analyst | data-analyst (03) |
| `analysis/scripts/01_clean.R` | data-analyst | data-analyst (03) |
| `analysis/scripts/02_descriptive.R` | data-analyst | data-analyst (03) |
| `analysis/scripts/03_main.R` | data-analyst | data-analyst (03) |
| `analysis/tables/tab_01_descriptive.tex` | data-analyst | writer (04) |
| `analysis/tables/tab_02_main.tex` | data-analyst | writer (04) |
| `analysis/results_log.md` | data-analyst | data-analyst (03), writer (04), internal-reviewer (04) |

---

## Schema 3: Storytelling Blueprint (AEF03_extend → AEF04_writeup)

**Producer**: `AEF03_extend/data-analyst`
**Consumer**: `AEF04_writeup/writer`

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `main_story` | string | 主线故事：主回归说明了什么 |
| `robustness_narrative` | list[object] | 哪些稳健性检验支撑了主结果 |
| `mechanism_narrative` | list[object] | 通过什么渠道起作用 |
| `heterogeneity_narrative` | list[object] | 在哪些群体/情境下效应更强/更弱 |
| `contribution_story` | string | 这些结果如何串成一个有说服力的 contribution story |
| `table_inventory` | list[string] | 所有可用的 LaTeX 表格文件路径 |
| `figure_inventory` | list[string] | 所有可用的图表文件路径 |

### Artifacts

| File | Producer | Consumer |
|------|----------|----------|
| `writeup/storytelling.md` | data-analyst (03) | writer (04) — 写作的核心依据 |
| `analysis/results_log.md` | data-analyst (03) | writer (04), internal-reviewer (04), ethics-reviewer (04) |
| `analysis/scripts/04_robustness.R` | data-analyst (03) | — |
| `analysis/scripts/05_heterogeneity.R` | data-analyst (03) | — |
| `analysis/scripts/06_mechanism.R` | data-analyst (03) | — |
| `analysis/tables/*.tex` | data-analyst (03) | writer (04) via `\input{}` |
| `analysis/figures/*.pdf` | data-analyst (03) | writer (04) via `\includegraphics{}` |

---

## Schema 4: Paper Draft (AEF04_writeup → AEF05_exclusivity)

**Producer**: `AEF04_writeup/writer`
**Consumer**: `AEF05_exclusivity/journal-exclusivity-profiler` | `AEF05_exclusivity/exclusivity-rewriter` | `AEF06_connection/reviewer-scanner` | `AEF06_connection/protective-cover-writer`

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `main_tex` | file | 完整的 LaTeX 主文件 |
| `sections` | list[file] | 按章节拆分的 .tex 文件 |
| `references_bib` | file | 完整的 BibTeX 文件 |
| `review_status` | enum | `passed` / `revised` / `needs_work` |
| `review_rounds_completed` | integer | 已完成的内审轮次（0-2） |

### Artifacts

| File | Producer | Consumer |
|------|----------|----------|
| `main.tex` | writer | journal-exclusivity-profiler (05), exclusivity-rewriter (05), reviewer-scanner (06), protective-cover-writer (06), response-planner (07) |
| `sections/*.tex` | writer | exclusivity-rewriter (05) |
| `references.bib` | lit-sentinel + writer | citation-compliance (04) |
| `review/internal_review_report.md` | internal-reviewer | review-synthesizer |
| `review/devils_advocate_report.md` | devils-advocate | review-synthesizer |
| `review/ethics_review_report.md` | ethics-reviewer | review-synthesizer |
| `review/citation_audit_report.md` | citation-compliance | review-synthesizer |
| `review/revision_priority.md` | review-synthesizer | writer (revision) |

---

## Schema 5: Exclusivity Document (AEF05_exclusivity → AEF06_connection)

**Producer**: `AEF05_exclusivity/journal-exclusivity-profiler` + `AEF05_exclusivity/exclusivity-rewriter`
**Consumer**: `AEF06_connection/reviewer-scanner` | `AEF06_connection/protective-cover-writer` | `AEF07_rebuttal/response-planner`

### Artifacts

| File | Producer | Consumer |
|------|----------|----------|
| `strategy/exclusivity_document.md` | journal-exclusivity-profiler | reviewer-scanner (06), protective-cover-writer (06) |
| `strategy/exclusivity_revision_notes.md` | exclusivity-rewriter | protective-cover-writer (06), User |

---

## Schema 6: Connection, Nomination & Cover Letter (AEF06_connection → 投稿)

**Producer**: `AEF06_connection/connection-mapper` + `AEF06_connection/reviewer-scanner` + `AEF06_connection/protective-cover-writer`
**Consumer**: User (final)

### Artifacts

| File | Producer | Consumer |
|------|----------|----------|
| `strategy/connection_document.md` | connection-mapper | reviewer-scanner, protective-cover-writer, User |
| `strategy/potential_reviewers.md` | reviewer-scanner | protective-cover-writer, User |
| `strategy/cover_letter.md` | protective-cover-writer | User (final) |
| `strategy/submission_protection_notes.md` | protective-cover-writer | User (final) |

---

## Schema 7: Response Letter Skeleton (AEF07_rebuttal internal)

**Producer**: `AEF07_rebuttal/comment-decomposer`
**Consumer**: `AEF07_rebuttal/response-planner`

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `comment_id` | string | 编号（如 `SE-1`, `AE-1`, `R1-2`） |
| `source` | string | 来源（SE / AE / R1 / R2 / R3 ...） |
| `verbatim_comment` | string | reviewer 原文，必须零遗漏保留 |
| `core_concern` | string | 一句话核心关切 |
| `suggested_action` | string | 一句话建议动作 |
| `needs_substantive_revision` | enum | `yes` / `no` |
| `formal_response_draft` | string | 若无需 substantive revision，则提供 4 句正式回复草稿 |

### Artifacts

| File | Producer | Consumer |
|------|----------|----------|
| `review/response_letter_skeleton.md` | comment-decomposer | response-planner, User |

---

## Schema 8: Response Strategy (AEF07_rebuttal → 02-04 revision)

**Producer**: `AEF07_rebuttal/response-planner`
**Consumer**: `AEF02_identify/data-analyst` | `AEF03_extend/data-analyst` | `AEF04_writeup/writer`

### Artifacts

| File | Producer | Consumer |
|------|----------|----------|
| `review/response_strategy.md` | response-planner | User (确认策略) |
| `review/response_letter.md` | response-planner | User (审阅后提交) |
| `review/revision_tracking.md` | response-planner | data-analyst (02/03), writer (04), consistency-checker |

---

## Schema 9: Consistency Report (AEF07_rebuttal internal)

**Producer**: `AEF07_rebuttal/consistency-checker`
**Consumer**: User

### Artifacts

| File | Producer | Consumer |
|------|----------|----------|
| `review/consistency_report.md` | consistency-checker | User (逐条确认并修改) |

---

## Schema 10: Polished Response Letter (AEF07_rebuttal internal)

**Producer**: `AEF07_rebuttal/response-polisher`
**Consumer**: User | `AEF07_rebuttal/consistency-checker`

### Artifacts

| File | Producer | Consumer |
|------|----------|----------|
| `review/response_letter_polished.md` | response-polisher | User (审阅后定稿), consistency-checker |
| `review/polishing_notes.md` | response-polisher | User (确认未回应点与待确认项) |

---

## Validation Rules

1. **Required field check**: All schema fields marked as required are REQUIRED. Consumer agents MUST verify all required fields are present before proceeding
2. **Type check**: Fields must match declared types (e.g., `enum` values must be from the allowed set)
3. **Cross-reference check**: Reference IDs in storytelling must correspond to actual table/figure files; `\cite{}` keys must exist in `references.bib`
4. **Failure on missing**: If a required field is missing, return `HANDOFF_INCOMPLETE` with a list of missing fields; do NOT proceed with partial data
5. **Producer validation**: Producing agent must validate output against its schema BEFORE handoff
6. **Consumer validation**: Consuming agent should validate input on receipt and request re-generation if schema violations are found
7. **Citation gating**: No artifact containing `[UNVERIFIED]` references may pass to Stage 05 or beyond
8. **Storytelling gating**: `AEF04_writeup/writer` MUST NOT begin writing without `writeup/storytelling.md` from Stage AEF03_extend
