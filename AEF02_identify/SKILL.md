---
name: AEF02_identify
description: "基础识别设计工具箱：只做 design，不写代码。依据 references/ 下的方法文献总结（Oster、causal ML、Conley、good / bad controls）设计 credible、causal 的 baseline：estimand、specification、FE、clustering、controls 的 good / bad 判断、identification assumptions 及检验方式、alternative explanations 及排除方法、主要 threats。"
metadata:
  version: "1.1.0"
  last_updated: "2026-11-02"
  stage: "02"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# AEF02_identify：基础识别设计

- 用法：Read `agents/credible-baseline-identifier.md` 执行
- 典型顺序：`credible-baseline-identifier` → 用户按设计自行跑 baseline → 结果可扩展时进入 `AEF03_extend`
- Input / Output：menu 里的 input 只是来源示例；输入格式不限，输出默认在对话中给出，用户要求时才保存，保存位置由用户指定（见根 `SKILL.md` `## 6`）
- 本 stage 只做 design，不写代码、不跑代码

---
## 1. Agent menu

- `credible-baseline-identifier`：提出 baseline design，覆盖 estimand、specification、FE、clustering、controls 的 good / bad 判断、identification assumptions 及检验方式、alternative explanations 及排除方法、主要 threats；目标是 baseline credible、causal、排除了 alternatives、满足 design assumptions
  - 何时用：已选定研究设计或 proposal，需要设计 baseline 识别方案；或已有初步结果，需要检查 baseline 是否可信
  - Input：用户确认的研究设计或 proposal（文件或口头描述）、数据说明（如 `DATA_DESCRIPTION.md` 与 Identification Profile）；可选用户已有的初步结果
  - Output：baseline design
  - Rules：`references/oster.md`、`references/causal-ml.md`、`references/conley.md`、`references/good-bad-controls.md`
  - ★ 停下：设计完成后用户决定采用、修改或 pivot

---
## 2. Files

- `references/` 是用户维护的方法文献总结，新增内容直接改对应文件（见根 `SKILL.md` `## 5. Rule capture`）
- 本 stage 全部文件：`references/oster.md`、`references/causal-ml.md`、`references/conley.md`、`references/good-bad-controls.md`
