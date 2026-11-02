# Empirical Paper Forge

半自动学术研究多智能体框架。从原始数据到可投稿论文，覆盖 explore、identify、extend、writeup、投稿、R&R 全生命周期。
目标期刊级别：UTD 24 / FT 50。

## Skills Overview

| Skill | 目录 | 目的 | Agents |
|-------|------|------|--------|
| `AEF01_explore` | 研究问题生成 | 可先从模糊想法或零散 source 信息生成 `DATA_DESCRIPTION.md`，再从数据出发生成 3-5 个候选 RQ，完成文献锚定与 proposal 组装 | data-description-builder, data-scout, idea-scout, lit-sentinel, proposal-assembler |
| `AEF02_identify` | 基础实证分析 | 数据清洗、描述统计、主回归（初步结果） | data-analyst |
| `AEF03_extend` | 扩展分析、结果筛选与 storytelling | 稳健性、异质性、机制、识别策略强化；结果筛选；叙事蓝图 | data-analyst |
| `AEF04_writeup` | 论文写作与内审 | LaTeX 论文撰写 → devils-advocate 挑战 → 并行审查（3 agents）→ 综合 → 修订（最多 2 轮） | writer, devils-advocate, internal-reviewer, ethics-reviewer, citation-compliance, review-synthesizer |
| `AEF05_exclusivity` | 期刊定制 | 处理大批量 journal 文献、提炼 exclusivity 文档、再基于该文档改写 manuscript | journal-exclusivity-profiler, exclusivity-rewriter |
| `AEF06_connection` | 学术人脉与投稿 | 构建个人 Connection Document、扫描 SE/DE/AE/reviewer、撰写 cover letter 与 submission protection strategy | connection-mapper, reviewer-scanner, protective-cover-writer |
| `AEF07_rebuttal` | 审稿回复 | 零遗漏拆分 decision letter 与 reviewer comments、生成 response skeleton、逐条制定可迭代回应方案并与用户多轮讨论、已有 response letter 的语言润色、单文件 / 跨文件一致性检查 | comment-decomposer, response-planner, response-polisher, consistency-checker |

## Routing Rules

1. **从 explore 启动还是单阶段触发**：用户说"开始新论文"或"从头开始" → 从 `AEF01_explore` 启动，按顺序推进。用户只需要某个阶段的功能（如"帮我写 rebuttal"）→ 直接触发对应 Skill，无需走完整流程。

2. **AEF01_explore 的前置数据说明规则**：如果用户还没有 `projects/<slug>/data/DATA_DESCRIPTION.md`，或者只有模糊想法、零散 source 信息、自然语言 data 描述，应先由 `data-description-builder` 生成标准化 `DATA_DESCRIPTION.md`，再交给 `data-scout`。

3. **AEF01_explore → AEF02_identify 的前提**：用户必须在 ★ 节点选定一个 idea 或确认 proposal 后才能进入 02。不要自动替用户做选择。

4. **AEF02_identify vs AEF03_extend**：02 = 基础回归与结果方向确认，03 = 全面扩展（稳健性 + 异质性 + 机制 + 识别策略强化）。02 的初步结果确认后才进入 03。

5. **AEF03_extend → AEF04_writeup 的衔接**：03 产出 `writeup/storytelling.md`，04 的 writer 以此为写作骨架。没有 `writeup/storytelling.md` 不要开始写论文。

6. **AEF04_writeup 内部循环**：writer 写稿 → devils-advocate Checkpoint 1（挑战假设）→ 3 个审查 agent 并行审查（internal-reviewer + ethics-reviewer + citation-compliance）→ review-synthesizer 综合 → writer 修订 → devils-advocate Checkpoint 2（验证修改质量）。最多 2 轮。每轮需用户确认修改优先级。

7. **05 和 06 的顺序**：先 05（处理目标 journal 的大批量文献并形成 exclusivity document，再据此定制 manuscript），再 06（基于 connection document 与 journal-specific nomination 扫描结果撰写 cover letter 和 protection strategy）。

8. **AEF07_rebuttal 的触发**：仅在收到审稿意见后触发。用户粘贴 decision letter 与 reviewer comments → comment-decomposer 零遗漏拆分并生成 response skeleton → response-planner 逐条提出可迭代回应方案，并在不明确处与用户多轮讨论 → 可能回到 AEF02_identify-AEF04_writeup 执行修改 → response-polisher 按 `AEF07_rebuttal/references/response-polishing-guide.md` 对已有 response letter 做语言润色（不改实质内容，也可单独触发）→ 重新投稿前由 consistency-checker 按 `AEF07_rebuttal/references/consistency-checklist.md` 检查 manuscript、response letter、appendix 的一致性（也可单独触发）。

## 核心规则

- 所有文献引用必须通过 `doi.org` 验证，零容忍虚构引用
- Agent 之间通过本地文件传递状态（文件即接口），详见 `shared/handoff_schemas.md`
- 每个 ★ 节点必须停下等待用户决策，不擅自推进
- 每个 Agent 只读取自己职责范围内的文件（上下文隔离）
- R 脚本遵循 `shared/r-conventions.md`；分析维度遵循 `shared/analysis-dimensions.md`
- 所有产出英文学术文本的 agent（manuscript、response letter、cover letter 等）遵循 `shared/writing-principles.md`
- 论文中所有数字必须来自 R 脚本输出（通过 `\input{}` 引用），禁止手动填写
- 默认输出语言跟随用户输入语言

## 完整工作流

```text
[用户提供模糊想法 / 零散 data source / DATA_DESCRIPTION.md]
      ↓
AEF01_explore
  ├─ 若无 DATA_DESCRIPTION.md：data-description-builder → projects/<slug>/data/DATA_DESCRIPTION.md
  └─ data-scout → idea-scout → lit-sentinel → proposal-assembler
      ↓
      → writeup/ideas/idea_candidates.md, writeup/proposal.md  ★ 用户选定 idea / proposal
      ↓
AEF02_identify     → preliminary results, results_log.md       ★ 用户确认分析方案 + 结果
      ↓
AEF03_extend       → writeup/storytelling.md, results_log.md   ★ 用户确认叙事蓝图
      ↓
AEF04_writeup      → main.tex, sections/                       ★ 用户确认大纲 + 审阅草稿
      ↓              ↓
                 → review reports                            ★ 用户确认修改优先级
      ↓                                                     ↺ 写作→审查→修改（最多 2 轮）
AEF05_exclusivity  → exclusivity_document.md                  ★ 用户确认 journal exclusivity 文档
                 → exclusivity_revision_notes.md            ★ 用户确认 manuscript adaptation
      ↓
AEF06_connection   → connection_document.md                    ★ 用户确认个人 connection 文档
                 → potential_reviewers.md                   ★ 用户确认 nomination 方向
                 → cover_letter.md                          ★ 用户审阅 cover letter 与 protection strategy
      ↓
[投稿]
      ↓
AEF07_rebuttal     → response_letter_skeleton.md              ★ 用户确认 comment 拆分结果
                 → response_strategy.md                     ★ 用户确认逐条回应方案
                 → response_letter.md                       ★ 用户审阅最终 Response Letter
      ↓                                                     ↺ 回到 AEF02_identify-AEF04_writeup 执行修改
[重新投稿]
```

★ = 必须停下来等待用户决策

## Handoff Protocol

详见 `shared/handoff_schemas.md` 获取完整的跨阶段数据交接契约。

### AEF01_explore 内部前置交接
交接物：`projects/<slug>/data/DATA_DESCRIPTION.md`
说明：若用户尚未提供标准化数据说明文件，由 `data-description-builder` 先生成，再交给 `data-scout`。

### AEF01_explore → AEF02_identify
交接物：选定的 RQ、锚定文献列表（`references.bib`）、`writeup/ideas/idea_candidates.md` 中被选中的条目、`writeup/proposal.md`

### AEF02_identify → AEF03_extend
交接物：清洗后数据、初步回归结果、`results_log.md`

### AEF03_extend → AEF04_writeup
交接物：`writeup/storytelling.md`（叙事蓝图）、完整 `results_log.md`、所有 LaTeX 表格

### AEF04_writeup → AEF05_exclusivity
交接物：完整论文 `main.tex`、所有审查报告（internal_review + devils_advocate + ethics_review + citation_audit）、`revision_priority.md`

### AEF05_exclusivity → AEF06_connection
交接物：`exclusivity_document.md`、`exclusivity_revision_notes.md`、目标期刊名称、定制修改后的论文

### AEF06_connection → [投稿]
交接物：`connection_document.md`、`potential_reviewers.md`、`cover_letter.md`、`submission_protection_notes.md`、最终论文

### [审稿意见] → AEF07_rebuttal
交接物：用户粘贴的 decision letter、AE report、reviewer comments 原文

### AEF07_rebuttal → AEF02_identify-AEF04_writeup（修订循环）
交接物：`response_letter_skeleton.md`、`response_strategy.md`、`revision_tracking.md`、需要重做的分析/写作清单

## Workspace convention

- `empiricalPaperForge/` 是 toolkit 仓库
- 实际论文项目默认放在外层 `bullet_paper/projects/`
- 推荐项目结构以 `data/`、`analysis/`、`writeup/` 和 `key_insights_outline.md` 为主
- `writeup/` 放 ideas、literature、proposal、storytelling、outline、draft 等写作相关文件
- `analysis/` 允许按分析任务拆分子文件夹（如 `01_baseline_panel/`）
- starter 参考见 `starter/minimal_project/`

## 启动方式

| 用户意图 | 触发方式 |
|---------|---------|
| 从零开始新论文 | "开始新论文，topic: `<slug>`" → 从 `AEF01_explore` 启动；若无 `DATA_DESCRIPTION.md`，先生成；可参考 `starter/minimal_project/` 的文件组织 |
| 只做选题 | "帮我 explore 研究问题" → 触发 `AEF01_explore` |
| 先整理数据说明 | "帮我写 DATA_DESCRIPTION.md" / "帮我整理数据源" → 触发 `AEF01_explore` 中的 `data-description-builder` |
| 只做基础实证 | "帮我做 identify 阶段分析" / "帮我跑回归" → 触发 `AEF02_identify` |
| 只做扩展分析 | "帮我做 extend 阶段分析" / "帮我做稳健性检验" → 触发 `AEF03_extend` |
| 只写论文 | "帮我写论文" → 触发 `AEF04_writeup` |
| 期刊定制 | "帮我分析期刊匹配" → 触发 `AEF05_exclusivity` |
| 投稿准备 | "帮我写 cover letter" → 触发 `AEF06_connection` |
| 审稿回复 | "帮我写 rebuttal" → 触发 `AEF07_rebuttal` |

## 全局共用规范

- [shared/citation-rules.md](../shared/citation-rules.md) — Citation 验证硬性规则
- [shared/r-conventions.md](../shared/r-conventions.md) — R 脚本规范
- [shared/analysis-dimensions.md](../shared/analysis-dimensions.md) — 分析维度与调参规范
- [shared/handoff_schemas.md](../shared/handoff_schemas.md) — 跨阶段数据交接契约
- [shared/writing-principles.md](../shared/writing-principles.md) — 通用英文写作原则（所有写作类 agent 适用）

## Version Info
- **Version**: v1.0.0
- **Last Updated**: 2026-04-17
- **License**: MIT
