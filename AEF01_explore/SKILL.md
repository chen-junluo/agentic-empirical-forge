---
name: AEF01_explore
description: "从原始数据和现象出发，生成 3-5 个可行的研究问题，完成初步文献锚定。每个 idea 需有 ≥3 篇 UTD/FT50 先行研究支撑，用户选定后进入 AEF02_identify。"
metadata:
  version: "1.0.0"
  last_updated: "2026-04-17"
  stage: "01"
  pipeline: "empiricalPaperForge"
---

# Stage 01: explore — 研究问题生成与文献锚定

从原始数据和现象出发，生成有潜力、可执行的研究问题，并完成初步文献锚定。本阶段是整个 empiricalPaperForge 流水线的起点，输出的是verify过后的针对某个effect of interest的，具备坚实的数据基础和文献支撑的research proposal。

## Trigger Conditions

- Automatic Trigger: This skill automatically triggers when:
    - User needs to generate ideas
    - User wants to explore possibilities or directions
    - User wants to explore a research space and compare possible directions
    - User is unsure which research direction to pursue and wants multiple idea options
    - User wants help drafting or standardizing `DATA_DESCRIPTION.md`
    - User has a rough idea but no data description yet
    - User has data sources but has not yet organized them into a formal data description file
- Trigger Keywords
    - **English**: explore, idea, research idea, possibilities, directions, options, alternatives, generate ideas, new angles, perspectives, compare directions, data description, describe the data, dataset description, data sources, define the data
    - **简体中文**: 探索, 研究想法, 研究问题, 点子, 灵感, 可能性, 方向, 选项, 替代方案, 想法, 新角度, 视角, 比较方向, data description, 数据描述, 数据说明, 数据源整理, 描述数据

---

## Orchestration Workflow

```
User: "开始新论文" / "生成 idea" / "帮我写 DATA_DESCRIPTION.md"
     |
=== Step 0: DATA DESCRIPTION BUILDING (optional) ===
INPUT:  用户的模糊想法、零散 source 信息，或对 data 的自然语言描述
     |
     +-> [data-description-builder] -> projects/<slug>/data/DATA_DESCRIPTION.md
         - 追问 source family、accessible 约束、粒度、时间跨度、coverage、字段与 join key
         - 在信息不完整时保守成文，并显式标注缺口
         - 生成标准化 DATA_DESCRIPTION.md
     |
OUTPUT: projects/<slug>/data/DATA_DESCRIPTION.md
     |
=== Step 1: DATA PROFILING ===
INPUT:  projects/<slug>/data/DATA_DESCRIPTION.md（用户提供，或由 data-description-builder 生成）
     |
     +-> [data-scout] 读取 DATA_DESCRIPTION.md
         - 提取变量、时间跨度、粒度、覆盖范围
         - 识别自然实验与因果推断机会
         - 评估数据限制与独特优势
     |
OUTPUT: Data Profile（in-memory，不存档，传递给 idea-scout）
     |
=== Step 2: IDEA GENERATION ===
INPUT:  Data Profile（来自 data-scout）
     |
     +-> [idea-scout] -> idea_candidates.md
         - 结合 IS/经济学理论框架
         - 生成 3-5 个候选 idea
         - 为每个 idea 评估可行性（数据、方法、贡献）
         - 为每个 idea 初步识别 ≥3 篇锚点文献
     |
OUTPUT: projects/<slug>/writeup/ideas/idea_candidates.md
     |
     ★ 用户确认：选定 idea（或直接给出 effect of interest）
     |
=== Step 3: LITERATURE VERIFICATION ===
INPUT:  用户选定的 idea / 用户指定的 effect of interest
     |
     +-> [lit-sentinel] -> writeup/literature/literature_review.md + references.bib
         - 通过 DOI 直接验证每篇锚点文献
         - 提取核心发现和与本研究的关联
         - 追加 VERIFIED 文献到 references.bib
         - 标记 UNVERIFIED / NOT FOUND 文献
     |
OUTPUT: projects/<slug>/writeup/literature/literature_review.md
       projects/<slug>/references.bib
     |
=== Step 4: PROPOSAL ASSEMBLY ===
INPUT:  writeup/ideas/idea_candidates.md（选定 idea）+ writeup/literature/literature_review.md + references.bib
     |
     +-> [proposal-assembler] -> writeup/proposal.md
         - 组装研究问题、机制、数据、识别策略
         - 整合已验证文献，形成叙事连贯的 proposal
         - 生成可交接给 Stage 02 的完整 research proposal
     |
OUTPUT: projects/<slug>/writeup/proposal.md
     |
     ★ 用户确认 proposal，进入 Stage 02
```

---

## Agent Team & Definition File

| # | Agent | Role | Definition File |
|---|-------|------|------------|
| 0 | `data-description-builder` | 数据说明构建专家：通过追问与整理，把模糊想法或零散 source 信息写成标准化 `DATA_DESCRIPTION.md` | `agents/data-description-builder.md` |
| 1 | `data-scout` | 数据画像专家：读取数据描述，提取结构特征，识别自然实验与因果推断机会，生成 Data Profile 传递给 idea-scout | `agents/data-scout.md` |
| 2 | `idea-scout` | 研究问题生成专家：接收 Data Profile，结合 IS/经济学理论框架，生成候选 idea 并评估可行性 | `agents/idea-scout.md` |
| 3 | `lit-sentinel` | 文献核查员：通过 DOI 直接验证每篇文献，确保零幻觉 | `agents/lit-sentinel.md` |
| 4 | `proposal-assembler` | 提案组装专家：整合选定 idea 与已验证文献，生成完整 research proposal | `agents/proposal-assembler.md` |

---

## Input and Output Rules

### Input
| File | Description |
|------|-------------|
| `projects/<slug>/data/DATA_DESCRIPTION.md` | 用户提供的数据说明文件，重点列出 data source、字段名、字段含义、合并键与缺口。可参考 `templates/data-description-template.md` |
| 用户自然语言 data 描述（可选） | 当 `DATA_DESCRIPTION.md` 尚不存在时，可由 `data-description-builder` 通过用户描述生成 |

### Output and Reference File

- Output Language: Follows the user's language. Academic terminology kept in English.

| Output File | Template | Reference | Reference Purpose |
|-------------|----------|-----------|-------------------|
| `projects/<slug>/data/DATA_DESCRIPTION.md` | `templates/data-description-template.md` | `templates/data-description-template.md` | 标准化数据说明文件；可由 `data-description-builder` 生成，供后续 agents 读取 |
| `projects/<slug>/writeup/ideas/idea_candidates.md` | `templates/idea-template.md` | `templates/data-description-template.md` | idea 候选输出格式规范；Data Scout 先从字段级数据说明中提炼可用变量与约束 |
| `projects/<slug>/writeup/literature/literature_review.md`（初步，≥3篇/idea） | — | `references/citation-rules.md` | Citation 验证硬性规则（含 DOI 直接验证） |
| `projects/<slug>/references.bib`（初步条目） | — | `references/citation-rules.md` | Citation 验证硬性规则（含 DOI 直接验证） |
| `projects/<slug>/writeup/proposal.md` | — | `references/citation-rules.md` | 最终 research proposal，交接给 Stage 02 |

注：Data Profile（data-scout → idea-scout）为 in-memory 传递，不生成文件。

- Output Quality Standards
    1. **Every claim must have a citation** — no unsupported assertions
    2. **Evidence hierarchy** — meta-analyses > RCTs > cohort studies > case reports > expert opinion
    3. **Contradiction disclosure** — if sources disagree, report both sides with evidence quality comparison
    4. **Limitation transparency** — every report must have an explicit limitations section
    5. **AI disclosure** — all reports include a statement that AI-assisted research tools were used
    6. **Reproducibility** — search strategies, inclusion criteria, and analytical methods must be documented for replication

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-04-19 | First public v1.0.0 release |
