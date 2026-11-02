---
name: AEF03_extend
description: "在 preliminary results 基础上进入 extend 阶段，系统扩展分析（稳健性、异质性、机制、识别策略强化），筛选 work 的结果，组合成 `writeup/storytelling.md` 传给 AEF04_writeup。"
metadata:
  version: "1.0.0"
  last_updated: "2026-04-17"
  stage: "03"
  pipeline: "empiricalPaperForge"
  target_journals: "UTD 24 / FT 50"
---

# Stage 03: extend — 扩展分析、结果筛选与 Storytelling

实证研究中，大量分析不显著是常态。本阶段的核心逻辑是：先扩展，再筛选，再组织叙事。

## Objectives

- 批量尝试尽可能多的分析组合（稳健性、异质性、机制、识别策略强化）
- 从所有扩展结果中筛选值得保留的分析（显著、方向合理、效应量有经济意义）
- 将筛选结果组合成 `writeup/storytelling.md`，作为 AEF04_writeup 的叙事蓝图

## Human-in-the-Loop Checkpoints

| Checkpoint | Timing | User Action |
|------------|--------|-------------|
| 分析菜单确认 | 扩展前 | Agent 提出分析菜单，用户选择优先级和范围 |
| 结果筛选确认 | 筛选后 | Agent 呈现 WORK / NOT WORK 结果摘要，用户确认哪些进入 storytelling |
| 叙事审阅 | 叙事后 | 用户审阅 `writeup/storytelling.md`，确认叙事逻辑后才进入 AEF04_writeup |

## Orchestration Workflow

```text
Stage 02 preliminary results
        │
        ▼
Phase 1: Extend
- robustness
- heterogeneity
- mechanism
- identification strengthening
        │
        ▼
★ User confirms analysis menu
        │
        ▼
Phase 2: Triage
- tag WORK / NOT WORK / MARGINAL
- keep full trace in `results_log.md`
        │
        ▼
★ User confirms result selection
        │
        ▼
Phase 3: Storytelling
- organize surviving findings
- produce `writeup/storytelling.md`
        │
        ▼
★ User reviews narrative logic
        │
        ▼
Stage 04: writeup
```

## Three-Phase Flow

### Phase 1: Extend

批量尝试尽可能多的分析组合：

| Category | Examples |
|----------|----------|
| 稳健性检验 | 替换 DV/IV 定义、样本窗口、控制变量、聚类 SE、安慰剂 |
| 异质性分析 | 分组、交互项 |
| 机制检验 | 中介、渠道 |
| 识别策略强化 | IV、DID、RDD |

每个分析跑完后立即记录到 `results_log.md`，标注显著性、系数方向、效应量、是否符合理论预期。

### Phase 2: Triage

从所有扩展结果中挑选 work 的分析。筛选标准：

1. 统计显著（p < 0.05 或 0.10，视领域惯例）
2. 系数方向与理论预期一致
3. 效应量有经济意义
4. 多个稳健性检验中结果稳定

不 work 的分析不丢弃，保留在 `results_log.md` 中备查，但不进入 storytelling。

### Phase 3: Storytelling

将筛选出的结果组合成一份 `writeup/storytelling.md`。这不是论文，而是传给 AEF04_writeup 的叙事蓝图：

- 主线故事：主回归说明了什么
- 稳健性：哪些检验支撑了主结果的可信度
- 机制：通过什么渠道起作用
- 异质性：在哪些群体或情境下效应更强或更弱
- 叙事逻辑：这些结果如何串成一个有说服力的 contribution story

---

## Agent Team (1 Agent)

| # | Agent | Role | Definition |
|---|-------|------|------------|
| 1 | `data-analyst` | 计量经济学分析师：批量执行扩展分析、筛选结果、产出 storytelling 文档 | `agents/data-analyst.md` |

## References

| Reference | Purpose | Used By |
|-----------|---------|---------|
| `references/identification-checklist.md` | 因果识别策略清单（DID、IV、RDD、FE 及其诊断要求） | data-analyst |
| `<AEF_ROOT>/shared/r-conventions.md` | R 脚本规范（全局共用） | data-analyst |
| `<AEF_ROOT>/shared/analysis-dimensions.md` | 分析维度与调参规范（全局共用） | data-analyst |

## Templates

| Template | Purpose |
|----------|---------|
| `templates/analysis-menu.md` | extend 阶段分析选项菜单模板 |
| `templates/storytelling-template.md` | Storytelling 文档模板（传给 AEF04_writeup 的叙事蓝图） |

## Input

- `projects/<slug>/analysis/scripts/03_main.R`（已有主回归）
- `projects/<slug>/analysis/analysis_plan.md`
- `projects/<slug>/analysis/results_log.md`（02 阶段的 preliminary results）

## Output

- `projects/<slug>/analysis/scripts/04_robustness.R`
- `projects/<slug>/analysis/scripts/05_heterogeneity.R`
- `projects/<slug>/analysis/scripts/06_mechanism.R`
- 对应 `.tex` 表格和 `.pdf` 图表
- `projects/<slug>/analysis/results_log.md`（更新，含所有扩展结果）
- `projects/<slug>/writeup/storytelling.md`（核心输出：叙事蓝图，传给 AEF04_writeup）

## Directory Structure

```text
AEF03_extend/
├── SKILL.md
├── agents/
│   └── data-analyst.md
├── references/
│   ├── identification-checklist.md
│   ├── r-conventions.md
│   └── analysis-dimensions.md
└── templates/
```

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-04-19 | First public v1.0.0 release |
