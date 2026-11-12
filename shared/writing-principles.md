# 通用写作原则（Writing Principles）

> 适用于：所有 AEF skill 中产出英文学术文本的 agent（manuscript、response letter、cover letter 等）。本文件是通用写作规则的唯一来源；各 stage `references/` 中的专项规则在此基础上叠加，不得与本文件冲突。

- 维护规则：新增规则在对应类别下加一个 bullet，开头写一个本文件内不重复的英文短标签（如 **No em-dashes**），agent 按标签引用；条目顺序没有意义，不需要编号；新类别直接新增 `## N. ...`
- 使用方式：agent 写作或改写时逐条遵守；输出前按 `## 4. 输出前自检` 检查一遍；table 的呈现规则见 `shared/table-conventions.md`

---

## 1. 硬性规则（Hard Rules）

Apply the following rules strictly throughout any output text:

- **No em-dashes.** Do not use em-dashes (—) anywhere. Restructure sentences that would otherwise require them.
- **No trailing participial claims.** Do not attach an analytical or interpretive claim to the end of a sentence as a participial phrase. For example, do not write "The population grew to 56,000, creating a lively community within its borders" and do not write "The bridge was completed in 1904, contributing to the socio-economic development of the region." Every analytical claim must stand as its own sentence with its own subject and verb.
- **Simple but formal.** Write in a register appropriate for academic research writing: precise, direct, and formal, but not unnecessarily complex. Avoid jargon when a plain word is equally accurate. Avoid casual phrasing.

---

## 2. 用词准确

- **Precise verbs** 动词要准确：例如 `attribute` 的意思是"归因"，用之前先想清楚要表达的是 focus 还是归因，不要混用

---

## 3. 减少 AI 味道

- **No overstated verbs** 不要用 `underscore`、`characterize` 这类词，这些词太过了
- **No represent** 避免使用 `represent` 或 `serve as`。比如 "A represents B"（A 代表了 B），很多情况下直接说 "A is B" 就可以了
- **No role phrasing** 类似 `play the role of` 或 `serve as` 这类词，很多情况下不需要用，直接说 A is 什么样子就完了
- **No "Yet,"** 避免 `Yet` 后面加逗号的写法（"Yet, ..."），这是 AI 非常喜欢用的表达方式
- **Other AI words** 其他 AI 常用词：`conflate x with y`；`supplying` 改为 `providing`；避免 `instantiates`、`defining`、`characterize`、`resonates`、`utilize`、`intricate`、`delving into`

---

## 4. 输出前自检

- 搜索 `—` 字符，结果必须为 0
- 检查每个以 `, <word>ing ...` 结尾的句子，属于 **No trailing participial claims** 的就拆成独立句子（`including` 除外）
- 搜索 `## 3. 减少 AI 味道` 中列出的词与句式（含其变形，如 `characterizes`、`represented`、`serves as`），能直接改写的就改写
- 搜索 `% level`，按 **Explicit p** 改写；搜索 `fitted`、`(fit)`，按 `shared/table-conventions.md` **No fitted label** 改写
- 检查每一处跨 regression 的系数比较（**Result not procedure**）和每一处变体描述（**Base-increment-share**）

---

## 5. 结果与数字表述

- **Result not procedure** [用户] 比较两个不同 regression 里的系数（用 nested / stacked 的方式检验）时，不要讲太多系数差距 test 的细节，直接说两个系数差多少、是否显著。细节讲多了，读者会觉得在被教育。
  - [补充] 避免：解释 stacked system 如何得到两个估计的 covariance、点名具体检验的名称、逐列复述 first-stage F 的变化
  - [补充] 改为："The coefficient is 0.15 under the baseline definition and 0.14 under the broader definition; the two do not differ significantly (p = 0.48)."；检验方法最多在 table note 中用一句话交代
- **Base-increment-share** [用户] 描述一个主要变量的变体（如放宽定义、换 threshold）时，先说基数，再说增量，再说增量占基数的比例，让读者清楚相比基数增量实际占多少。
  - [补充] 例："Under the baseline definition, 20.0% of observations are treated. The three broader definitions add 1.0, 1.5, and 2.0 percentage points, that is, 5%, 8%, and 10% of the baseline."
- **Category anatomy** [用户] 介绍分类分析时要先交代清楚：这些类别是否互斥？是否穷尽所有观测，还是有 "Other" 类？各类别以什么方式进入回归、reference group 是什么？不交代清楚，读者会追问 multicollinearity。
  - [补充] 写之前回到原始 coding 确认是否每个观测都有分类、"Other" 是否存在，不凭印象写
- **Explicit p** [补充] 显著性用 p 值阈值表述（"p < 0.001"），不写 "significant at the 0.1% level" 这类容易误读的说法；文字中的显著性与 table 星号一致
- **No speculative add-ons** [补充] 结果段落不追加超出证据的解读句（如从一组系数推出 "A complements rather than replaces B"）；需要解读时只保留与主 story 直接相关的一句，并写成 "One possible explanation is ..."
