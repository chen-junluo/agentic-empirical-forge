# Table 呈现规范（Table Conventions）

> 适用于：所有 AEF skill 中产出、润色或检查 table 的 agent（manuscript、online appendix、response letter），包括 `AEF04_writeup` 的 `writer`，`AEF07_rebuttal` 的 `response-letter-writer`、`response-polisher`、`consistency-checker`。本文件是 table 呈现规则的唯一来源；通用写作规则见 `shared/writing-principles.md`。

- 维护规则
  - 新增规则：在对应类别下加一个 bullet，开头写一个本文件内不重复的英文短标签（如 **No fitted label**），agent 按标签引用；条目顺序没有意义，不需要编号；新的分析类型直接新增 `## N. ...`
  - 来源标记：`[用户]` = 用户原始要求；`[补充]` = 落地说明或示例，用户可删改
- 范围：只管 table 怎么呈现（label、header、notes、列与行的组织），不改估计结果与数字
  - Word 版式（三线表、字号、行顺序、caption）见 `AEF07_rebuttal/references/response-letter-docx-format.md` `## 2`；行名与正文定义一致见该文件 **Label match**

---

## 1. 通用规则（所有 table）

- **Significance note** [用户] 每张 table 下都要加 note，说明显著性符号对应的阈值。
  - [补充] 如 "*Notes.* Standard errors clustered by [unit] in parentheses. † p < 0.10; \* p < 0.05; \*\* p < 0.01; \*\*\* p < 0.001."；阈值全文统一，并与正文的显著性表述一致（见 `shared/writing-principles.md` **Explicit p**）
- **Reference group note** [补充] 自变量是 dummy 或分类 indicators 时，note 写明 reference group，即各系数相对于谁比较
- **Self-explanatory labels** [补充] label 要让读者不看正文也能看懂每行每列是什么
  - 用完整短语，不用只有希腊字母或模糊指代：写 "Adjusted coefficient" 而非 "β (adjusted)"，写 "95% CI" 而非 "CI"，写 "(vs. baseline)" 而非 "(vs. Column 2)"
  - "名称: 内容" 类的行统一格式，如 "Instrument: *x*"、"Test of equal coef., p-value (vs. baseline)"
- **Header carries variation** [补充] 跨列变化的设定（treatment 定义、threshold、sample、estimator）放在 header 行，写清设定名称与每列取值，不放在 table 底部的 Yes / No 行
  - 例："Definition of treatment: Baseline only / Similarity > 80% / Similarity > 70%"；"Frequency threshold: Baseline (> 5) / Looser (> 4) / Stricter (> 6)"
- **Label restraint** [用户] label 改得清楚是好事，但不要比正文定义更具体，以免提醒读者想到已知的 concern。
  - [补充] 例：instrument 在正文中定义为某种 similarity measure，label 就沿用该 measure 的名称；改写成 "number of similar X" 会让人联想到它与规模（workload、volume）相关

---

## 2. 2SLS / IV table

- **No fitted label** [用户] 2SLS 第二阶段的 endogenous variable 直接写变量名，不写 `fitted(x)`、`x(fit)`、"(fitted) x"。
  - [补充] 第一阶段与第二阶段用 header 区分（如 "First stage / Second stage"），不靠变量名标记
- **First-stage stats** [补充] first-stage F 放在 table 底部的统计行；正文不逐列复述它的变化，除非 instrument strength 正是被讨论的问题

---

## 3. 跨 regression 的系数比较

- **Comparison row** [补充] 比较不同 regression 的系数（如 nested / stacked 检验）时，在 table 中加一行 "Test of equal coef., p-value (vs. baseline)"；检验方法最多在 note 中用一句话交代，正文只报告结论（见 `shared/writing-principles.md` **Result not procedure**）

---

## 4. 分类变量 table

- **Category rows** [补充] 分类 indicators 作为自变量时，行顺序与正文介绍类别的顺序一致；存在 "Other" 类时一并列出；note 写明类别是否互斥以及 reference group（见 `shared/writing-principles.md` **Category anatomy**）
