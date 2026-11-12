---
name: AEF05_exclusivity
description: "期刊定制工具箱：对目标期刊已发表论文做文献综述（用户提供或通过 OpenAlex 检索），提炼该 journal 的 topics、methods、framing、contribution style、section 排布、偏好与排斥项，形成可迭代的 Exclusivity Document；再据此对 manuscript 做结构、framing、语气的定向改写。两个 agent 均可单独调用。"
metadata:
  version: "1.2.0"
  last_updated: "2026-11-12"
  stage: "05"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# AEF05_exclusivity：期刊定制与行文排他性

- 用法：按用户意图从 agent menu 选一个 agent，Read `agents/<name>.md` 执行；不需要从第一个 agent 开始
- 典型顺序：`journal-profiler` → `journal-tailor`
- Input / Output：menu 里的 input 只是来源示例；输入格式不限，输出默认在对话中给出，用户要求时才保存，保存位置由用户指定（见根 `SKILL.md` `## 6`）

---
## 1. Agent menu

- `journal-profiler`：对目标期刊已发表论文做文献综述，把它们当作 corpus 阅读，总结 topics、methods、开篇方式、贡献 framing、contribution style、section 结构、语气，以及期刊偏好与排斥项
  - 何时用：确定目标期刊后，需要了解它的写作惯例；或补充新文献更新已有文档
  - Input：要考虑的 journal（一本或多本，用户说明即可）、corpus 所在位置（没有时通过 OpenAlex 检索）；可选 topic、时间窗、当前 manuscript 作对照
  - Output：Exclusivity Document（多本期刊时每本一份 + 跨期刊对比）
  - Rules：`<AEF_ROOT>/shared/citation-rules.md`、`<AEF_ROOT>/shared/openalex-protocol.md`、`templates/journal-profile-template.md`、`templates/journal-fit-report-template.md`
  - ★ 停下：开始前用户确认 journal 与 corpus；需要 OpenAlex 检索时，先确认期刊列表、时间窗、topic 过滤与样本量；完成后用户审阅 Exclusivity Document
- `journal-tailor`：对照 Exclusivity Document 找出 manuscript 的偏离，先改结构、framing、语气，再做细节修改
  - 何时用：已有 Exclusivity Document，需要据此修改论文
  - Input：Exclusivity Document 与 manuscript（位置、格式不限，用户告知即可）；可选用户指定不能改动的内容
  - Output：修改建议与 revision notes；用户确认后才修改 manuscript（`.tex` 或 `.docx`）
  - Rules：`templates/journal-fit-report-template.md`、`<AEF_ROOT>/shared/writing-principles.md`
  - ★ 停下：动手改 manuscript 前用户确认修改方向（含 notes 中的 `Open Decisions for User`）

---
## 2. Files

- 本 stage 无 `references/`；citation 与 OpenAlex 规则统一维护在 `<AEF_ROOT>/shared/citation-rules.md`、`<AEF_ROOT>/shared/openalex-protocol.md`
- 本 stage 全部文件：`templates/journal-profile-template.md`、`templates/journal-fit-report-template.md`
