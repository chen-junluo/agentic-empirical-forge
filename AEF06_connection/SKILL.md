---
name: AEF06_connection
description: "投稿策略工具箱：引导用户整理与 senior scholars 的 connection 痕迹形成个人 Connection Document、对某期刊某 topic 的 potential SE/DE、AE、reviewer 的发表记录做文献综述并给出 justification、结合两者撰写 cover letter 与 submission protection strategy。三个 agent 均可单独调用。"
metadata:
  version: "1.2.0"
  last_updated: "2026-11-12"
  stage: "06"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# AEF06_connection：学术人脉、提名与 Cover Letter

- 用法：按用户意图从 agent menu 选一个 agent，Read `agents/<name>.md` 执行；不需要从第一个 agent 开始
- 典型顺序：`connection-scout` → `reviewer-profiler` → `cover-letter-writer`
- Input / Output：menu 里的 input 只是来源示例；输入格式不限，输出默认在对话中给出，用户要求时才保存，保存位置由用户指定（见根 `SKILL.md` `## 6`）

---
## 1. Agent menu

- `connection-scout`：追问合作、会议、seminar、访问、通信等所有 connection 渠道，按 scholar 和类型整理，保守估计关系强度
  - 何时用：首次建立或更新个人 Connection Document
  - Input：用户提供的学术活动与 scholar 接触记录；可选已有 connection 笔记
  - Output：Connection Document
  - Rules：`templates/connection-file-template.md`
  - ★ 停下：用户审阅并补充 Connection Document
- `reviewer-profiler`：对目标期刊 SE/DE、AE 与潜在 reviewer 的发表记录做文献综述，按 topic fit、method fit、对相关研究的立场分别列出候选及基于 verified 文献的 justification，标出风险名单；并主动追问用户与候选人之间未记录的合作者、supporter 关系
  - 何时用：确定目标期刊和稿件主题后，需要 nomination 候选或挖掘潜在 connection
  - Input：目标期刊（用户说明即可）、manuscript 或其摘要；可选 Exclusivity Document、Connection Document
  - Output：potential reviewer document（含 `Retrieval Log`、`Connection Leads`）
  - Rules：`<AEF_ROOT>/shared/citation-rules.md`、`<AEF_ROOT>/shared/openalex-protocol.md`、`references/nomination-strategy.md`、`templates/nomination-report-template.md`
  - ★ 停下：批量 OpenAlex 检索前用户确认候选范围；用户确认 connection leads，并审阅候选名单、确认 nomination / exclusion 方向
- `cover-letter-writer`：结合 connection 与 nomination 材料撰写期刊定制的 cover letter，并从 editor fit、reviewer fit、exclusion、framing 提出保护策略
  - 何时用：准备投稿，需要 cover letter 或保护策略
  - Input：Connection Document、potential reviewer document、manuscript（任意格式）、目标期刊；可选 Exclusivity Document
  - Output：cover letter、submission protection notes
  - Rules：`references/cover-letter-guide.md`、`templates/cover-letter-template.md`、`<AEF_ROOT>/shared/writing-principles.md`
  - ★ 停下：用户审阅 cover letter 与 protection notes（含 `User Decisions Needed`）

---
## 2. Files

- `references/` 是用户维护的规则文件，新增规则直接改对应文件（见根 `SKILL.md` `## 5. Rule capture`）
- 本 stage 全部文件：`references/nomination-strategy.md`、`references/cover-letter-guide.md`、`templates/connection-file-template.md`、`templates/nomination-report-template.md`、`templates/cover-letter-template.md`
