---
name: agentic-empirical-forge
description: "AEF (Agentic Empirical Forge) router：实证论文全流程 skill 的统一入口，负责识别用户意图和项目状态，再加载对应的 sub-skill：AEF01_explore（选题、DATA_DESCRIPTION、文献验证与综述、proposal）、AEF02_identify（baseline 识别设计，只做 design）、AEF03_extend（机制、异质性等扩展分析设计、结果筛选、storytelling，只做 design）、AEF04_writeup（LaTeX 写作与内审）、AEF05_exclusivity（期刊定制）、AEF06_connection（cover letter、reviewer 提名）、AEF07_rebuttal（审稿回复）。用户提到 AEF、AEF-explore、AEF01、AEF-writeup 这类 AEF-<stage> / AEF0X 名称，或 agentic-empirical-forge、empirical paper forge 时触发；用户说开始新论文、帮我选题、设计识别策略、做稳健性、写论文、写 cover letter、写 rebuttal 时也触发。"
metadata:
  version: "1.2.0"
  last_updated: "2026-11-12"
  role: "router"
---

# AEF Router

本文件只做路由：识别目标 stage，加载对应 sub-skill，具体执行规则全部以 sub-skill 的 `SKILL.md` 为准。

---
## 1. Sub-skill 注册表

- 下文 `<AEF_ROOT>` 指本 `SKILL.md` 所在目录（即 skill base directory）；所有 sub-skill 与 `shared/` 都在其下
- `AEF01_explore`：别名 `AEF-explore`、`AEF01`、`explore`、选题、文献综述、citation 检查；做 `DATA_DESCRIPTION.md` → 候选 RQ → 文献验证与综述 → proposal
- `AEF02_identify`：别名 `AEF-identify`、`AEF02`、`identify`、baseline 设计；只做 design，不写代码：设计 credible、causal 的 baseline
- `AEF03_extend`：别名 `AEF-extend`、`AEF03`、`extend`、稳健性/异质性/机制；只做 design，不写代码：设计扩展分析、筛选用户提供的结果 → storytelling 蓝图
- `AEF04_writeup`：别名 `AEF-writeup`、`AEF04`、`writeup`、写论文；做 LaTeX 写作 + 内审循环（最多 2 轮）→ manuscript、review report
- `AEF05_exclusivity`：别名 `AEF-exclusivity`、`AEF05`、期刊定制；属于 advanced，产出 Exclusivity Document
- `AEF06_connection`：别名 `AEF-connection`、`AEF06`、cover letter、reviewer 提名；属于 advanced，产出 cover letter
- `AEF07_rebuttal`：别名 `AEF-rebuttal`、`AEF07`、rebuttal、R&R；属于 advanced，产出 response letter

---
## 2. 路由规则（按优先级）

1. **显式点名**：用户消息中出现上表任一别名（大小写、`-`/`_`/空格不敏感，如 `AEF explore`、`aef_01`）→ 直接加载该 sub-skill，不做状态推断、不二次确认
2. **意图匹配**：没有点名但意图明确（如"帮我写 rebuttal"、"做稳健性检验"）→ 按别名列中的关键词匹配到对应 sub-skill 后加载；意图对应单个 agent 时直接定位到该 agent（如"润色 response letter"→ `AEF07_rebuttal` 的 `response-polisher`、"查一致性"→ `consistency-checker`、"做稳健性"→ `AEF03_extend` 的 `extension-designer`、"查引用"→ `AEF01_explore` 的 `literature-reviewer`），加载 stage `SKILL.md` 后直接调用该 agent，不从第一个 agent 开始
3. **状态推断**：意图模糊（如"继续"、"下一步做什么"、"开始新论文"）→ 按 §3 判断进度，提出建议的 stage 并说明依据，**等用户确认后再加载**
4. **无法判断**：用 `AskUserQuestion` 让用户在候选 stage 中选择，不要擅自猜测

---
## 3. 项目状态推断

- 项目位置与文件结构由用户自行管理，本 skill 不规定项目路径或输出路径
- 根据对话上下文判断进度：用户说了做到哪一步、贴了或指向了什么材料；按 stage 从后往前，第一个命中的即为建议 stage：
    - 有 decision letter / reviewer comments，或 response letter skeleton → `AEF07_rebuttal`
    - 有 Exclusivity Document → `AEF06_connection`
    - 有 manuscript 且已有 review report → `AEF05_exclusivity`（advanced，需先确认用户是否要做）
    - 有 storytelling 蓝图 → `AEF04_writeup`
    - 有 baseline design 或 baseline 结果 → `AEF03_extend`（先确认 baseline 已被用户认可）
    - 有 proposal → `AEF02_identify`
    - 其他情况 → `AEF01_explore`（还没有数据说明时，先走 `data-description-builder`）
- 仍判断不了时直接问用户
- Gating（软约束）：不强制按 stage 顺序；调用 agent 前看手头材料是否够用，不够时告诉用户缺什么内容，请用户提供等价材料（任意格式）或先运行产出它的 agent，由用户决定；agent 自身的 ★ 停下点仍必须遵守

---
## 4. 加载方式

- 用 Read 读取 `<AEF_ROOT>/<AEFxx_name>/SKILL.md`，按 agent menu 选择 agent，再 Read 该 `agents/<name>.md` 执行；该文件中的相对路径（`agents/`、`references/`、`templates/`）都相对于 `<AEF_ROOT>/<AEFxx_name>/` 解析
- 全局规范统一从 `<AEF_ROOT>/shared/` 读取，包括 `citation-rules.md`（检查 reference）、`openalex-protocol.md`（稳定访问 OpenAlex）、`writing-principles.md`（所有产出英文文本的 agent 都要遵守）、`table-conventions.md`（所有 table 的呈现）；sub-skill 里写的 `../../shared/` 一律按此处理
- 开始执行前先用一行告诉用户：`→ 加载 AEFxx_name（原因：显式点名 / 意图匹配 / 状态推断）`
- 一个 agent 完成并通过 ★ 点后，可按典型顺序提示下一步，不自动执行

---
## 5. Rule capture（session 内规则沉淀）

- 识别：用户对产出提出否定或改写要求（"这样不好"、"改成…"、"不要…"、"以后都…"）时，在内部记下原话与提炼出的规则；**不当场询问、不调用 `AskUserQuestion`、不自动修改 skill 文件**，避免打断当前 workflow
- 过滤：只收下次同类任务仍适用的规则；只针对本篇 paper 的内容修改（某个数字、某段论证）不收；目标文件已有的规则不重复提出
- 输出时机：完成一个交付物（如 polished letter、consistency report）且自上次输出后有新规则时，附在该回复末尾；用户说"收尾"或 "rule capture" 时立即输出；已输出过的规则不再重复
- 落点：每条规则指定一个目标文件和其中的 `##` 类别
  - response letter 的称呼、立场、语气、结构 → `AEF07_rebuttal/references/response-polishing-guide.md`
  - manuscript、response letter、appendix 的一致性检查项 → `AEF07_rebuttal/references/consistency-checklist.md`
  - 所有英文写作通用规则（含结果与数字表述）→ `shared/writing-principles.md`
  - table 呈现（label、header、notes，manuscript 与 response 通用）→ `shared/table-conventions.md`
  - 回应策略（close the case、minor comment 定性、新内容在 manuscript 中的位置）→ `AEF07_rebuttal/references/response-strategy.md`
  - agent 执行方式（何时停下来问、输出格式、流程步骤）→ 对应的 `<AEFxx_name>/agents/<agent>.md`
  - 其他 stage 的规则 → 该 stage `references/` 下最相关的文件，没有合适文件时标注"建议新建"
- 格式：每条 1–3 行，按目标文件现有格式写好，用户改完可直接粘贴
  ```markdown
  ## Skill 更新建议
  - → `AEF07_rebuttal/references/response-polishing-guide.md` / `## 3. 语气`
    - **No hedging stacks** [用户] 不要连用 "may possibly" 这类叠加的弱化词。（原话："..."）
  ```
- 写入：用户明确要求写入时，才按落点写入，并确认短标签在目标文件内不重复

---
## 6. 输入与输出（所有 stage、所有 agent 适用）

- Input 不设限：stage menu 与 `agents/*.md` 里写的 input 只是常见来源示例
  - 用户说明材料在哪、要做什么即可；`.md`、`.docx`、`.txt`、`.pdf`、`.tex` 或直接粘贴都接受，`.docx` 用 `pandoc -t markdown` 读取
  - 材料缺失或不足时先问用户，不因缺某个指定文件拒绝执行
- Output 默认不落盘：第一步永远不写文件，结果先在对话中给出；用户明确要求保存时才写
  - 格式按用户要求（`.md`、`.docx` 等）；保存位置与文件名由用户指定，skill 不规定输出路径
  - 例外：LaTeX 表格、manuscript 正文必须写文件才能工作；动手前先列出要新建 / 修改的文件，用户确认后再写
  - `templates/` 只规定内容结构，不限制文件格式
- 数字：不编造数字
  - 不确定的数字留 placeholder `[[NUM: 说明]]`，不估算、不凭印象填写
  - 确定的数字注明来源脚本与表格（脚本由用户运行，agent 不写代码）：LaTeX 用 `\input{}` 或行尾 `%` 注释；Word / Markdown 用 `[src: <script> → <table>]`，投稿前由用户清理
