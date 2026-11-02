# Empirical Paper Forge Changelog

Cross-skill fixes and update history.

---

## 2026-04-17

### v1.0.0 — Public local-skill baseline

**Framework**: file-driven Claude Code skill toolkit for empirical business-school research.

**Changes**:
- Standardized all release metadata to `v1.0.0`.
- Standardized project writing artifacts under `writeup/`:
  - `writeup/ideas/idea_candidates.md`
  - `writeup/literature/literature_review.md`
  - `writeup/proposal.md`
  - `writeup/storytelling.md`
  - `writeup/outline.md`
- Removed references to non-bundled example folders.
- Added README roadmap, current status, installation instructions, and requirements.
- Switched license to MIT.
- Removed deprecated Stage 05 agent references from current documentation.

**Skills**:
- `01_explore`: 研究问题生成与文献锚定
- `02_identify`: 基础实证分析
- `03_extend`: 扩展分析与 storytelling
- `04_writeup`: 论文写作与内部审查
- `05_exclusivity`: 期刊定制与投稿策略
- `06_connection`: 学术人脉与投稿
- `07_rebuttal`: 审稿回复与修订

**Shared conventions**:
- `shared/citation-rules.md` — DOI 验证硬性规则
- `shared/r-conventions.md` — R 脚本规范
- `shared/analysis-dimensions.md` — 分析维度与调参规范
- `shared/handoff_schemas.md` — 跨阶段数据交接契约
