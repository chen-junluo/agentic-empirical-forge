# Citation 验证规则（全局）

> 适用于所有阶段所有 Agent

---

## 硬性规则（不可违反）

### 1. DOI 直接验证（必须执行）

所有文献必须通过 `https://doi.org/<DOI>` 直接 fetch 验证：

| 结果 | 标记 |
|------|------|
| 返回正常页面，标题/作者一致 | `[VERIFIED]` |
| 返回 404 | `[UNVERIFIED - DOI 404]` |
| 无 DOI，但有官方页面可验证 | `[VERIFIED via URL]` |
| 完全找不到 | `[NOT FOUND]` |

**这比"搜到了就算验证"更可靠。不得跳过此步骤。**

### 2. 禁止捏造

- 不得捏造 DOI、卷号、页码、作者名
- 找不到就如实说，标记 `[NOT FOUND]`
- 宁可少引，不可错引

### 3. UNVERIFIED 文献禁止入正文

- `[UNVERIFIED]` 和 `[NOT FOUND]` 的文献**禁止出现在论文正文和 references.bib**
- 可在 `writeup/literature/literature_review.md` 中保留记录，注明状态

---

## 验证流程

```
1. WebSearch: "作者 标题 期刊 年份 site:semanticscholar.org"
2. 从搜索结果提取 DOI
3. WebFetch: https://doi.org/<DOI>
4. 确认标题、作者、期刊与预期一致
5. 写入 literature.md，标注验证状态
6. 追加到 references.bib（仅 VERIFIED）
```

---

## BibTeX 条目规范

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

缺少 `doi` 时必须提供 `url` 字段。

---

## 文献规模管理

- 超过 30 篇时，拆分为 `literature_part1.md`、`literature_part2.md`
- 每个文件顶部注明覆盖范围（如"理论基础"、"方法类"）
