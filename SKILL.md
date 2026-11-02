---
name: agentic-empirical-forge
description: "AEF (Agentic Empirical Forge) router：实证论文全流程 skill 的统一入口，负责识别用户意图和项目状态，再加载对应的 sub-skill：AEF01_explore（选题、DATA_DESCRIPTION、文献锚定、proposal）、AEF02_identify（数据清洗、描述统计、主回归）、AEF03_extend（稳健性、异质性、机制、storytelling）、AEF04_writeup（LaTeX 写作与内审）、AEF05_exclusivity（期刊定制）、AEF06_connection（cover letter、reviewer 提名）、AEF07_rebuttal（审稿回复）。用户提到 AEF、AEF-explore、AEF01、AEF-writeup 这类 AEF-<stage> / AEF0X 名称，或 agentic-empirical-forge、empirical paper forge 时触发；用户说开始新论文、帮我选题、跑回归、做稳健性、写论文、写 cover letter、写 rebuttal 时也触发。"
metadata:
  version: "1.1.0"
  last_updated: "2026-11-02"
  role: "router"
---

# AEF Router

本文件只做路由：识别目标 stage，加载对应 sub-skill，具体执行规则全部以 sub-skill 的 `SKILL.md` 为准。

---
## 1. Sub-skill 注册表

- 下文 `<AEF_ROOT>` 指本 `SKILL.md` 所在目录（即 skill base directory）；所有 sub-skill 与 `shared/` 都在其下
- `AEF01_explore`：别名 `AEF-explore`、`AEF01`、`explore`、选题；做 `DATA_DESCRIPTION.md` → 候选 RQ → 文献锚定 → `writeup/proposal.md`
- `AEF02_identify`：别名 `AEF-identify`、`AEF02`、`identify`、跑回归；做数据清洗、描述统计、主回归 → `analysis/results_log.md`
- `AEF03_extend`：别名 `AEF-extend`、`AEF03`、`extend`、稳健性/异质性/机制；做扩展分析、结果筛选 → `writeup/storytelling.md`
- `AEF04_writeup`：别名 `AEF-writeup`、`AEF04`、`writeup`、写论文；做 LaTeX 写作 + 内审循环（最多 2 轮）→ `main.tex`、`review/*`
- `AEF05_exclusivity`：别名 `AEF-exclusivity`、`AEF05`、期刊定制；属于 advanced，产出 `strategy/exclusivity_document.md`
- `AEF06_connection`：别名 `AEF-connection`、`AEF06`、cover letter、reviewer 提名；属于 advanced，产出 `strategy/cover_letter.md`
- `AEF07_rebuttal`：别名 `AEF-rebuttal`、`AEF07`、rebuttal、R&R；属于 advanced，产出 `review/response_letter.md`

---
## 2. 路由规则（按优先级）

1. **显式点名**：用户消息中出现上表任一别名（大小写、`-`/`_`/空格不敏感，如 `AEF explore`、`aef_01`）→ 直接加载该 sub-skill，不做状态推断、不二次确认
2. **意图匹配**：没有点名但意图明确（如"帮我写 rebuttal"、"做稳健性检验"）→ 按别名列中的关键词匹配到对应 sub-skill 后加载
3. **状态推断**：意图模糊（如"继续"、"下一步做什么"、"开始新论文"）→ 按 §3 检查项目文件，提出建议的 stage 并说明依据，**等用户确认后再加载**
4. **无法判断**：用 `AskUserQuestion` 让用户在候选 stage 中选择，不要擅自猜测

---
## 3. 项目状态推断

- 项目位置默认是 `bullet_paper/projects/<slug>/`；有多个项目且无法从上下文确定时，先问用户选哪个 `<slug>`
- 从最后一个阶段往前判断，第一个命中的规则即为建议 stage：
    - 用户贴出了 decision letter / reviewer comments，或存在 `review/response_letter_skeleton.md` → `AEF07_rebuttal`
    - 存在 `strategy/exclusivity_document.md` → `AEF06_connection`
    - 存在 `main.tex` 且 `review/revision_priority.md` 已存在 → `AEF05_exclusivity`（advanced，需先确认用户是否要做）
    - 存在 `writeup/storytelling.md` → `AEF04_writeup`
    - 存在 `analysis/results_log.md` → `AEF03_extend`（先确认 02 的初步结果已被用户认可）
    - 存在 `writeup/proposal.md` 或 `writeup/ideas/idea_candidates.md` 中已有选定 idea → `AEF02_identify`
    - 其他情况 → `AEF01_explore`（缺少 `data/DATA_DESCRIPTION.md` 时，先走 `data-description-builder`）
- Gating：不能跳过 ★ 节点；例如没有 `writeup/storytelling.md` 就不能进入 `AEF04_writeup` 写正文，此时应提示用户先完成 `AEF03_extend`

---
## 4. 加载方式

- 用 Read 读取 `<AEF_ROOT>/<AEFxx_name>/SKILL.md`，然后按其中的流程执行；该文件中的相对路径（`agents/`、`references/`、`templates/`）都相对于 `<AEF_ROOT>/<AEFxx_name>/` 解析
- 全局规范统一从 `<AEF_ROOT>/shared/` 读取，包括 `citation-rules.md`、`r-conventions.md`、`analysis-dimensions.md`、`handoff_schemas.md`、`writing-principles.md`（所有产出英文文本的 agent 都要遵守）；sub-skill 里写的 `../../shared/` 一律按此处理
- 开始执行前先用一行告诉用户：`→ 加载 AEFxx_name（原因：显式点名 / 意图匹配 / 状态推断）`
- 一个 stage 完成并通过 ★ 节点后，只提示下一个 stage 的名称，不自动开始执行

---
## 5. Rule capture（session 内规则沉淀）

- 识别：用户对产出提出否定或改写要求（"这样不好"、"改成…"、"不要…"、"以后都…"）时，在内部记下原话与提炼出的规则；**不当场询问、不调用 `AskUserQuestion`、不自动修改 skill 文件**，避免打断当前 workflow
- 过滤：只收下次同类任务仍适用的规则；只针对本篇 paper 的内容修改（某个数字、某段论证）不收；目标文件已有的规则不重复提出
- 输出时机：完成一个交付物（如 polished letter、consistency report）且自上次输出后有新规则时，附在该回复末尾；用户说"收尾"或 "rule capture" 时立即输出；已输出过的规则不再重复
- 落点：每条规则指定一个目标文件和其中的 `##` 类别
  - response letter 的称呼、立场、语气、结构 → `AEF07_rebuttal/references/response-polishing-guide.md`
  - manuscript、response letter、appendix 的一致性检查项 → `AEF07_rebuttal/references/consistency-checklist.md`
  - 所有英文写作通用规则 → `shared/writing-principles.md`
  - agent 执行方式（何时停下来问、输出格式、流程步骤）→ 对应的 `<AEFxx_name>/agents/<agent>.md`
  - 其他 stage 的规则 → 该 stage `references/` 下最相关的文件，没有合适文件时标注"建议新建"
- 格式：每条 1–3 行，按目标文件现有格式写好，用户改完可直接粘贴
  ```markdown
  ## Skill 更新建议
  - → `AEF07_rebuttal/references/response-polishing-guide.md` / `## 3. 语气`
    - **No hedging stacks** [用户] 不要连用 "may possibly" 这类叠加的弱化词。（原话："..."）
  ```
- 写入：用户明确要求写入时，才按落点写入，并确认短标签在目标文件内不重复
