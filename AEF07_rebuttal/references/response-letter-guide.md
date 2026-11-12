# Response Letter 写作规范（Response Letter Guide）

> 适用于：AEF07_rebuttal 的 `response-letter-writer` agent。本文件定义完整 response letter 的写法，尤其是 editor 部分与 reviewer 部分的不同要求；称呼、立场、语气、结构沿用 `references/response-polishing-guide.md`，回应策略见 `references/response-strategy.md`，通用写作规则见 `shared/writing-principles.md`，table 呈现见 `shared/table-conventions.md`，全部同时适用。

- 维护规则
  - 新增要求：在对应类别下加一个 bullet，开头写一个本文件内不重复的英文短标签（如 **Max three points**），agent 按标签引用；条目顺序没有意义，不需要编号；新类别直接新增 `## N. ...`
  - 来源标记：`[用户]` = 用户原始要求（保留原话）；`[补充]` = 落地说明或示例，用户可删改
- 范围：实质内容全部来自用户对 reviewer comments 的逐条回复；agent 负责成文与整合，不新增用户材料里没有的修改、分析、数字或承诺

---

## 1. 定位：Editors 与 Reviewers 分开写

- **Editors skim** [用户] 针对 editors 和 reviewers 是不一样的。editors（尤其是高级 editor）没那么多时间看，所以我们不要讲那么多细节；reviewers 则需要点对点回应。
- **Show effort** [用户] 保持简洁，但也要适当重复已在 reviewer 回复中写过的细节，体现 effort。
  - [补充] 重复的是具体动作（新增了什么分析、改了哪一节），不是整段搬运 reviewer 回复
- **Editors first** [补充] letter 顺序：开头 → SE / DE / AE 部分 → R1、R2… 部分 → 结尾

---

## 2. Editor 部分（SE / DE / AE）

- **Specific thanks** [用户] 开头：一句简短、具体的感谢（点到这条 comment 的实质）。
  - [补充] 避免："Thank you for this insightful comment."（空泛，且评价了 comment，与 **No evaluating comments** 冲突）
  - [补充] 改为："Thank you for raising the concern about how [X] is identified."
- **Max three points** [用户] 正文：简要说明我们为回应该 concern 做了哪些努力，最多 3 个点。
- **Source tag** [用户] 每个点明确标注来源：（integrated from RX-Y）。
  - [补充] 一个点整合了多条 reviewer 回复时一并列出，如 "(integrated from R1-2, R3-1)"
- **Location pointer** [用户] 结尾指向具体修改位置：修改见 Section/Table/Figure/Page X。
  - [补充] 位置只取自用户回复或 manuscript 中已有的信息，不猜页码；缺失时留 `[Page ?]` 并提醒用户
- **Concise overall** [用户] 整体篇幅：简洁高效。

---

## 3. Reviewer 部分

- **Reviewer point-by-point** [用户] reviewers 则需要点对点回应。
  - [补充] 每条 comment 先原文引用，再按用户的逐条回复成文；comment 里的每个点都要有对应回应，用户没回应的点不代写，列入 notes 提醒
  - [补充] 每条回复结尾写明修改位置，与 `templates/response-letter-template.md` 的 **Changes made** 一致
- **Hat paragraph** [用户] 对 minor 或探索性的 comment，回复开头先写一段"帽子"定性（策略见 `references/response-strategy.md` **Position as exploratory**），帽子之后加几句：我们只有一个 identification 工具，无法 estimate 这些 causal effects；以下结果是 exploratory / suggestive 的；更 definitive 的答案可能需要 randomized experiment。

---

## 4. 新增分析的写法（editor 与 reviewer 部分通用）

- **Analysis paragraph order** [补充] 介绍一项新分析时按以下顺序，每段以加粗的总结式 lead-in 开头（**Bold topic sentence**）
  1. 做法与定义：新变量或放宽后的定义如何构造
  2. 描述性量级：按 `shared/writing-principles.md` **Base-increment-share**
  3. 比较方法，一句话：按 `shared/writing-principles.md` **Result not procedure**
  4. 逐个 outcome 报告结果，lead-in 写 outcome 与 table 编号，如 "**[Outcome] (Table X).**"
  5. 一句 "In short, ..." 总结
  6. implication
- **Theory close** [补充] 当 editor 或 reviewer 期望分析 enrich theoretical contribution 时，用 "**Theoretical implication: [claim].**" 一段收尾：先给结论式标题，再给支持它的结果，再用 "we argue" 给出原因并连接文献；原因与文献另起一段，不和结果挤在一起
