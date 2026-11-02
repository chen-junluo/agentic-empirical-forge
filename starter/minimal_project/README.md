# Minimal Project Starter

这是 Empirical Paper Forge 的主路径 MVP starter。

它遵循当前建议的项目结构：

- `data/` 保持原始数据与数据说明
- `writeup/` 放 ideas、literature、proposal、storytelling、outline、draft 等写作相关文件
- `analysis/` 放 analysis plan、results log，以及按分析任务拆分的子文件夹
- `key_insights_outline.md` 放在 project 根目录，作为跨阶段持续维护的高层摘要

建议把这个 starter 当成结构参考，而不是直接当成真实项目结论。

## Current release boundary

当前 starter 已覆盖主路径 MVP：

- explore: `DATA_DESCRIPTION.md` → `writeup/ideas/idea_candidates.md` → `writeup/proposal.md`
- identify: `analysis_plan.md` → `results_log.md` → `analysis/01_baseline_panel/`
- extend: `analysis/02_uncertainty_interaction/` → `writeup/storytelling.md`
- writeup: `writeup/outline.md` → `writeup/draft.md` → `main.tex` + `sections/`

尚未覆盖的部分：

- 可运行的真实 R 脚本
- 已验证的参考文献条目
- 内置 journal profile 包
- 完整 rebuttal 示例包

## Runnable starter assets

当前 starter 已包含两组 runnable-style analysis scaffolding：

- `analysis/01_baseline_panel/`
  - `01_build_sample.R`
  - `02_descriptive.R`
  - `03_main.R`
  - `tab_01_main.tex`
- `analysis/02_uncertainty_interaction/`
  - `01_define_shock.R`
  - `02_interaction_model.R`
  - `tab_02_uncertainty_interaction.tex`

这些文件的目标不是立即跑通真实数据，而是展示主路径中 analysis module 应该如何组织。
