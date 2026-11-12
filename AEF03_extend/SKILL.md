---
name: AEF03_extend
description: "扩展分析设计工具箱：只做 design，不写代码。基于用户确认的 credible baseline，依据 references/ 下的 mechanisms、policy learning、identification checklist 设计 mechanism、heterogeneity 与其他 insightful 的分析；对用户提供的结果按 WORK / NOT WORK / MARGINAL 筛选，把保留结果组织成 storytelling 叙事蓝图。按任务拆为三个条目，均可单独调用。"
metadata:
  version: "1.2.0"
  last_updated: "2026-11-12"
  stage: "03"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# AEF03_extend：扩展分析设计、结果筛选与 Storytelling

- 用法：按用户意图从 agent menu 选一个条目，Read `agents/extension-designer.md` 执行；不需要从第一个条目开始
- 典型顺序：`extension-designer`（扩展设计）→ 用户自行跑分析 → `extension-designer`（结果筛选）→ `extension-designer`（storytelling）→ `AEF04_writeup`
- Input / Output：menu 里的 input 只是来源示例；输入格式不限，输出默认在对话中给出，用户要求时才保存，保存位置由用户指定（见根 `SKILL.md` `## 6`）
- 本 stage 只做 design，不写代码、不跑代码

---
## 1. Agent menu

- `extension-designer`（扩展设计）：基于用户确认的 credible baseline，设计 mechanism、heterogeneity 与其他 insightful 的分析（识别策略强化、policy learning、针对具体 threat 的稳健性），逐项说明要回答的问题、specification、预期结果与 null 结果的含义
  - 何时用：baseline 已被用户确认，需要设计机制 / 异质性 / 稳健性 / IV、DID、RDD 等扩展
  - Input：用户确认的 baseline（`credible-baseline-identifier` 的 design 或口头描述）、用户已跑出的 baseline 结果（results log、表格或总结）
  - Output：extension design
  - Rules：`references/identification-checklist.md`、`references/mechanisms.md`、`references/policy-learning.md`
  - ★ 停下：用户在设计中选择范围与优先级
- `extension-designer`（结果筛选）：对用户提供的每个扩展结果打 WORK / NOT WORK / MARGINAL 标签
  - 何时用：用户已跑完扩展分析，需要决定哪些结果进入叙事
  - Input：用户提供的结果（results log、表格或总结，任意格式）
  - Output：带标签的 results log、WORK / NOT WORK 摘要
  - Rules：`agents/extension-designer.md` 的 `## Triage Criteria`
  - ★ 停下：用户确认哪些结果进入 storytelling
- `extension-designer`（storytelling）：把保留结果串成主线、稳健性、机制、异质性、contribution story，每个数字附用户报告的脚本与表格路径
  - 何时用：结果筛选已确认，准备交给 `AEF04_writeup`
  - Input：已确认筛选的 results log、表格与图
  - Output：storytelling blueprint
  - Rules：`templates/storytelling-template.md`
  - ★ 停下：用户审阅叙事逻辑

---
## 2. Files

- `references/` 是用户维护的规则文件，新增规则直接改对应文件（见根 `SKILL.md` `## 5. Rule capture`）
- 本 stage 全部文件：`references/identification-checklist.md`、`references/mechanisms.md`、`references/policy-learning.md`、`templates/storytelling-template.md`
