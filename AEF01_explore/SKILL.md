---
name: AEF01_explore
description: "研究选题工具箱：把模糊想法或零散 source 整理成标准化 DATA_DESCRIPTION.md 并理清数据能支持的 identification、生成 3-5 个候选 RQ 并评估可行性、批量验证文献真伪与 claim-abstract 一致性、整理 reference 格式并按需撰写 literature review、基于 idea 与 literature review 起草 research proposal。四个 agent 均可单独调用。"
metadata:
  version: "1.1.0"
  last_updated: "2026-11-02"
  stage: "01"
  pipeline: "empiricalPaperForge"
---

# AEF01_explore：研究问题生成与文献锚定

- 用法：按用户意图从 agent menu 选一个 agent，Read `agents/<name>.md` 执行；不需要从第一个 agent 开始
- 典型顺序：`data-description-builder` → `idea-scout` → `literature-reviewer` → `proposal-drafter`
- Input / Output：menu 里的 input 只是来源示例；输入格式不限，输出默认在对话中给出，用户要求时才保存，保存位置由用户指定（见根 `SKILL.md` `## 6`）

---
## 1. Agent menu

- `data-description-builder`：通过追问把模糊想法、零散 source 或自然语言 data 描述写成标准化数据说明，并画像数据、理清数据能支持的 identification（unit of observation、panel 结构、treatment / variation 来源与 timing、潜在 confounders、可行的 identification strategy）；不写 RQ、假设、贡献
  - 何时用：缺 `DATA_DESCRIPTION.md`、用户要求整理数据源，或生成 idea 前需要摸清数据
  - Input：用户的模糊想法、source 清单、data 描述或已有 `DATA_DESCRIPTION.md`；可选文件名、变量名、截图、可得性 / 时间 / 地域约束
  - Output：`DATA_DESCRIPTION.md`、Identification Profile、未解决的数据缺口清单（如有）
  - Rules：`templates/data-description-template.md`
  - ★ 停下：用户确认未解决的数据缺口（如有）
- `idea-scout`：结合 IS / 经济学理论生成 3-5 个候选 idea，逐个给出机制、数据匹配、识别策略、锚点文献、贡献、风险与可行性
  - 何时用：需要候选研究问题，或比较几个研究方向
  - Input：`DATA_DESCRIPTION.md`、Identification Profile；可选用户研究兴趣
  - Output：候选 idea 与推荐排序（在对话中讨论；用户要求时才输出文件，格式跟随用户）、交给 `literature-reviewer` 的锚点文献清单
  - Rules：`<AEF_ROOT>/shared/citation-rules.md`；`templates/idea-template.md` 仅作可选参考
  - ★ 停下：用户选定 idea，或直接给出 effect of interest
- `literature-reviewer`：a. 通过 OpenAlex 与 `doi.org` 批量验证文献是否存在；b. 拉取 abstract 检查每条引用的 claim，判定 `supported` / `partially supported` / `unsupported` / `abstract unavailable`；c. 按用户指定或目标 journal 的 style 整理 reference 格式；d. 按需撰写 literature review
  - 何时用：任何文献清单进入 workflow 之前（来自 `idea-scout`、`AEF04_writeup` 的 `writer` 或用户）；需要 literature review、claim 核查或 reference 格式整理时
  - Input：待验证文献清单、`.bib` 或 manuscript 参考文献；b 需要带引用的正文；c 需要 style 或目标 journal；d 需要 topic 或选定 idea
  - Output：验证报告、claim 一致性报告、格式化 reference list 或 literature review（用户要求 `docx` 时调用 `docx` skill）、verified 条目的 BibTeX（用户要求时追加到 `references.bib`）
  - Rules：`<AEF_ROOT>/shared/citation-rules.md`、`<AEF_ROOT>/shared/openalex-protocol.md`
  - ★ 停下：批量 OpenAlex 检索前用户确认范围；d 开始前用户确认 scope；修改 manuscript 或 `.bib` 前用户确认修改清单
- `proposal-drafter`：基于 idea 描述与 literature review 起草 research proposal（动机、理论与假设、数据与识别、贡献、风险）
  - 何时用：用户已有 idea 描述与 literature review
  - Input：格式不限，但必须同时包含 idea 描述和 literature review，缺任何一项就停下问用户；可选 `DATA_DESCRIPTION.md`、Identification Profile、`references.bib`
  - Output：research proposal（最终格式为用户提供的 Word template，见根 `TODO.md`；到位前沿用 agent 中的结构）
  - Rules：`<AEF_ROOT>/shared/citation-rules.md`
  - ★ 停下：缺 idea 描述或 literature review 时；用户确认 proposal

---
## 2. Stage 规则

- 本 stage 的报告（idea 文档、literature review、proposal）都要满足：
  - **Citation**：每个 claim 都有 verified 文献支撑，不写无依据断言
  - **Contradiction disclosure**：文献结论冲突时两边都报告，并比较证据质量
  - **Limitation**：每份报告有明确的 limitations 部分
  - **AI disclosure**：每份报告注明使用了 AI-assisted research tools
  - **Reproducibility**：记录检索策略、纳入标准与分析方法，便于复现

---
## 3. Files

- 本 stage 无 `references/`；citation 与 OpenAlex 规则统一维护在 `<AEF_ROOT>/shared/citation-rules.md`、`<AEF_ROOT>/shared/openalex-protocol.md`
- 本 stage 全部文件：`templates/data-description-template.md`、`templates/idea-template.md`
