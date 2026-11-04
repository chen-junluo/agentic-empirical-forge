# OpenAlex 访问协议（全局）

> 适用于：`AEF01_explore` 的 `literature-reviewer`、`AEF05_exclusivity` 的 `journal-profiler`、`AEF06_connection` 的 `reviewer-profiler`。本文件只管"稳定访问 OpenAlex"：endpoint、query、限速、重试、分页、fallback、失败报告；检索结果是否算验证过，按 `citation-rules.md` 判断。agent 现场组 query，不依赖脚本。

---
## 1. 检索前

- ★ 批量检索前先和用户确认范围：期刊或作者列表、时间窗、topic 过滤词、目标篇数、排序方式（默认 `cited_by_count:desc`）；单条 DOI 核对不需要确认
- Polite pool：每个请求带 `mailto=<YOUR_EMAIL>`
  - `<YOUR_EMAIL>` 由用户提供；用户没给时省略 `mailto`，不得用任何其他邮箱代填，也不得写入仓库文件
- API key：请求带 `api_key=<KEY>`
  - 用户有 key 就用用户的；没有 key 时共享同一 IP 的免费日额度，只跑小批量 query
  - 不得代用户申请 key（申请需要用户邮箱），只提示用户去 `https://openalex.org/settings/api` 自行获取
- 用户同时给了本地论文时，本地文件优先，OpenAlex 只用来补齐样本

---
## 2. Endpoints 与 query patterns

- Base URL：`https://api.openalex.org`
- 单篇文献：`/works/doi:<DOI>`；无 DOI 时 `/works?search=<title>&filter=publication_year:<YYYY>`，必须人工核对 title 与 authors
- 批量 DOI 核对：`/works?filter=doi:<DOI1>|<DOI2>|...&per_page=50`，每批 ≤ 50 个 DOI
- 期刊 → source ID
  - 已知 ISSN：`/sources/issn:<ISSN>`，最可靠
  - 只知道刊名：`/sources?search=<name>&select=id,display_name,issn_l`，同名刊多（如 `Management Science` vs `Pest Management Science`），必须核对 `display_name` 与 `issn_l`
- 期刊论文：`/works?filter=primary_location.source.id:<S_ID>,publication_year:<YYYY-YYYY>,type:article`
  - topic 过滤：`title_and_abstract.search:<terms>` 只匹配标题与摘要；`search=<terms>` 会匹配全文，范围更宽
- 作者 → author ID：`/authors?search=<name>&select=id,display_name,last_known_institutions,works_count`；同名作者多，必须用机构、研究领域、代表作核对
- 作者发表记录：`/works?filter=authorships.author.id:<A_ID>&sort=publication_date:desc`
- 只取需要的字段：`select=id,doi,title,publication_year,authorships,primary_location,abstract_inverted_index,best_oa_location,cited_by_count`
- 摘要：用 `abstract_inverted_index` 按位置还原；为空则记为无摘要
- 全文：`best_oa_location.pdf_url` 非空时可取开放获取 PDF；其余论文请用户提供 PDF

---
## 3. 限速、重试与分页

- 限速：按 OpenAlex 官方文档的当前限额执行（撰写时为每秒最多 10 次请求，并有每日额度）；连续请求之间留间隔，不并发猛刷
- 重试：遇到 `429` 或 `5xx` 时 exponential backoff 重试，间隔 1s → 2s → 4s → 8s → 16s，最多 5 次；响应带 `Retry-After` 时按其等待
- 不重试：`400`（query 写错，先修 query）、`404`（记录为未找到）
- 分页：`per_page=200&cursor=*`，用返回的 `meta.next_cursor` 翻页，直到为 `null` 或达到用户确认的目标篇数；不用 `page=` 翻超过 10,000 条

---
## 4. Fallback

- OpenAlex 查不到或重试用尽时，按顺序 fallback：
  - `https://doi.org/<DOI>`：确认文献存在与 metadata
  - Crossref：`https://api.crossref.org/works/<DOI>`（同样带 `mailto=<YOUR_EMAIL>`）；无 DOI 时 `https://api.crossref.org/works?query.bibliographic=<title author year>&rows=5`
  - 出版社或期刊官方页面
- fallback 拿到的摘要与 metadata 注明来源（`[via Crossref]`、`[via publisher]`）

---
## 5. 记录与失败报告

- 每次检索记录完整 query URL（去掉 `api_key` 与 `mailto`）、检索日期、返回总数 `meta.count`、实际纳入篇数，写进产出文档的检索记录（如 Exclusivity Document 的 `Corpus Scope`）
- 失败时如实报告，不静默跳过：列出失败的 query 或 DOI、HTTP 状态码、已重试次数、已尝试的 fallback、最终状态（按 `citation-rules.md` 标记）
- OpenAlex 只提供元数据与摘要；开篇方式、section 结构、语气这类判断需要全文
  - 只基于摘要得出的结论要标注 `[abstract-only]`
  - 全文样本太少时如实告诉用户，不从摘要推断 section 结构
- 多本期刊：每本单独 profile，再加一份跨期刊对比
