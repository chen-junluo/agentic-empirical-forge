# Citation 检查规则（全局）

> 适用于：所有阶段、所有引用文献的 agent。本文件只管"检查 reference"：文献是否存在、metadata 是否匹配、argument 与 abstract 是否一致、reference 格式、零虚构。如何稳定访问 OpenAlex（endpoint、限速、重试、fallback）见 `openalex-protocol.md`。

---
## 1. 文献是否存在（必须执行）

- 每条文献都要通过 `https://doi.org/<DOI>` 直接 fetch 验证；批量检索、补 DOI 先按 `openalex-protocol.md` 查 OpenAlex，再用 `doi.org` 确认
- 验证结果标记：
  - DOI 返回正常页面，且 metadata 一致 → `[VERIFIED]`
  - 无 DOI，但有官方页面（出版社、期刊、机构）可验证 → `[VERIFIED via URL]`
  - DOI 返回 404，或 metadata 不一致 → `[UNVERIFIED - 原因]`，如 `[UNVERIFIED - DOI 404]`、`[UNVERIFIED - title mismatch]`
  - 完全找不到 → `[NOT FOUND]`
- 搜到了不等于验证过，不得跳过 `doi.org` 这一步

---
## 2. Metadata 是否匹配

- 逐项核对 title、authors（顺序与拼写）、venue、year；有 volume、issue、pages 时一并核对
- 以 `doi.org` 指向的出版社页面为准；OpenAlex 与出版社页面冲突时，以出版社页面为准并注明
- online-first 与正式卷期年份不同时，两个年份都记录，如 `(2024; online first 2022)`

---
## 3. Argument 与 abstract 是否一致

- 每条引用的 claim 都要和被引文献的 abstract 对照，判定为以下之一，并附一行理由：
  - `supported`：abstract 直接支持该 claim
  - `partially supported`：abstract 只支持部分内容，或 claim 的范围、方向、强度超出 abstract
  - `unsupported`：abstract 不支持或与 claim 相反
  - `abstract unavailable`：拿不到 abstract；如实报告，不按标题或印象推断
- 非 `supported` 的条目给出改写建议或更合适的文献，由用户决定

---
## 4. Reference 格式

- style 跟随用户指定；用户未指定时用目标 journal 的 style，并说明用了哪个
- 正文引用与 reference list 双向一致：每个 in-text citation 都在 list 中，list 中每条都被引用
- 只格式化 VERIFIED 文献；修改 manuscript 或 `.bib` 前先列出修改清单，等用户确认
- BibTeX 条目规范：

```bibtex
@article{AuthorYYYY,
  author  = {Last, First and Last2, First2},
  title   = {Full Title of the Paper},
  journal = {Journal Name},
  year    = {YYYY},
  volume  = {XX},
  number  = {X},
  pages   = {XXX--XXX},
  doi     = {10.XXXX/XXXXX}
}
```

- 缺少 `doi` 时必须提供 `url` 字段

---
## 5. 零虚构

- 不得捏造 DOI、卷号、页码、作者名；找不到就如实标记 `[NOT FOUND]`，宁可少引，不可错引
- `[UNVERIFIED]` 与 `[NOT FOUND]` 文献禁止出现在论文正文和 `references.bib`；可在 literature review 或验证报告中保留记录并注明状态
- 文献超过 30 篇时拆分成多份，每份顶部注明覆盖范围（如"理论基础"、"方法类"）
