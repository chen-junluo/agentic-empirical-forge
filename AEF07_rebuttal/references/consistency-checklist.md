# 一致性检查清单（Consistency Checklist）

> 适用于：AEF07_rebuttal 的 `consistency-checker` agent。本文件是检查项的唯一来源（single source of truth），agent 不另行定义检查项。

- 维护规则
  - 新增检查项：在对应类别下加一个 bullet，开头写一个本文件内不重复的英文短标签（如 **Sample size**），agent 与报告按标签引用；条目顺序没有意义，不需要编号；新类别直接新增 `## N. ...`
  - 来源标记：`[用户]` = 用户原始要求（保留原话）；`[补充]` = 建议新增项，用户可删改，或确认后改为 `[用户]`
  - 适用模式紧跟来源标记：`[单文件]` / `[跨文件]` / `[两者]`
- 检查对象与模式
  - 文件：manuscript、response letter、appendix，大概率是 Word（`.docx`）文件
  - 单个文件模式：针对单个文件进行检查，文件可以是 manuscript、response letter，也可以是 appendix
  - 跨文件模式：把多个文件糅合到一起检查，也就是 cross documents、cross materials 的一致性

---

## 1. 数字、样本与设定一致性

- **Sample size** [用户] [两者] Sample size 的一致性：包括 regression 的 sample size，以及文章里有关 sample size 的描述。
  - 检查要点：每张 regression table 的 N、正文 / abstract / data section 描述的样本量、样本筛选流程逐步剔除后的数字、response letter 中提到的 N 互相对得上；不同 table 之间 N 的变化必须有解释（如 subsample、missing values）
- **Key estimates** [补充] [两者] 关键估计结果的引用一致：正文、abstract、response letter 中引用的 coefficient、standard error、显著性水平、effect size（如 "increases by 12%"）与对应 table 中的数字一致
- **Descriptive numbers** [补充] [两者] 描述性数字一致：样本期间（年份范围）、观测单位、公司 / 用户 / 地区数量、mean、percentage 等在不同位置一致
- **Model specification** [补充] [两者] 模型设定描述一致：estimator、fixed effects、clustering level、control variables 在正文方法描述、table notes、appendix 中一致
- **Significance wording** [补充] [两者] 文字中的显著性表述与 table 星号、note 阈值一致；不用 "0.1% level" 这类有歧义的写法（见 `shared/writing-principles.md` **Explicit p**）
- **Result direction** [补充] [两者] 结果解读方向一致：同一结果的符号（正 / 负）、显著与否、经济含义在 abstract、introduction、results、conclusion、response letter 中表述不矛盾

---

## 2. 术语一致性

- **Same term** [用户] [两者] 描述同一个东西时，不要在文章里一会儿用这个、一会儿用那个。
- **Reviewer wording** [用户] [两者] 如果某个概念是 reviewer 提到的，术语尽量以 reviewer 提到的为准，多用原话。
- **Abbreviations** [补充] [单文件] 缩写首次出现时定义，之后统一使用；不在定义前使用、不重复定义
- **Variable names** [补充] [两者] 变量名一致：同一变量在正文、table、variable definition appendix 中的名称与定义一致
- **Hypothesis naming** [补充] [两者] Hypothesis、construct、mechanism 的命名与编号全文一致（如 H1 不在别处变成 H1a，同一机制不换名字）

---

## 3. Cross-reference 一致性

- **Comment cross-refs** [用户] [单文件] 单个文件内（如 response letter）的交叉引用。最常见的是在某个 reviewer 的 comments（如 R1-2）里提到"参见 R1-4"，那就要核实 R1-4 里是不是真的有 R1-2 所指的内容。（跨 reviewer 引用如 "see our response to R2-3" 同样适用）
- **Location info** [用户] [两者] 仔细检查 section title、appendix title、table title 以及 page 等信息。
  - 检查要点：response letter 中写的 "Section 4.2, p. 15"、"Table A3" 等定位信息，与 manuscript / appendix 实际的标题、编号、页码一致，且被引用对象确实存在
- **Sub-heading style** [用户] [单文件] response letter 中同一层级的小标题 / 小 section 标记格式统一，不混用 (a)(b)、1. 2.、斜体句、加粗句（见 `references/response-polishing-guide.md` **Uniform sub-headings**）
- **Appendix order** [用户] [跨文件] 正文里 appendix 的顺序要顺下来：正文中第一个出现的必须是 Appendix A，第二个是 Appendix B，需要把 appendix 内部的顺序对应修改过来。（manuscript ↔ appendix）
- **Table/figure numbering** [补充] [两者] Table、figure 按正文首次引用顺序连续编号：无跳号、无重复、无"引用了却不存在"的 table / figure
- **Citation list** [补充] [单文件] 文中 citation 与 reference list 一一对应：引用了的都在 reference list，reference list 中的都被引用；作者名、年份拼写一致
- **Quoted revisions** [补充] [跨文件] Response letter 中引用的 manuscript 修改原文（quoted revised text）与 manuscript 当前版本逐字一致

---

## 4. 承诺与内容一致性

- **Promised changes** [用户] [两者] 比如 response letter 或 manuscript 里明明说了做了某些修改或补充，但后面实际没有做、没有披露对应细节，或者根本没写，这种情况也是不行的。（重点是跨文件）
  - 检查要点：逐条核对 response letter 中 "we have added / revised / conducted ..." 等承诺，在 manuscript / appendix 中找到对应内容；manuscript 中 "see Appendix X for details" 指向的位置确有相应细节
- **Comment coverage** [补充] [跨文件] Comment 覆盖完整：每条 reviewer comment 在 response letter 中都有回应；revision tracking 中标为 `DONE` 的项在 manuscript 中可找到对应修改
- **Consistent stance** [补充] [单文件] 回应立场一致：对同一问题，回应不同 reviewer 或同一 reviewer 的不同 comment 时，立场与理由不相互矛盾（如对 R1 说"不做"、对 R2 说"已做"）（response letter）
- **Stale wording** [补充] [单文件] 修订后无残留旧表述：新增分析或新 framing 之后，abstract、introduction、conclusion 等未同步更新的段落不再与新内容冲突（manuscript）
- **Unbacked claims** [用户] [单文件] letter 里声称做过、但没给出证据的分析，比如 "results unchanged when…"、inter-coder agreement，直接删掉。
  - [补充] `consistency-checker` 只报告不改文件：列出该句及缺失的证据（table / appendix / 数字），suggested fix 写"删除"，由用户决定
- **Category anatomy** [用户] [两者] 分类分析写清类别是否互斥、是否穷尽（有无 "Other"）、reference group 是什么；各类别观测数加总与总数对得上（见 `shared/writing-principles.md` **Category anatomy**）
- **Ripple check** [用户] [跨文件] 一处分析、定义或分类改动后（如某类内容重新归类、某张 table 删列），所有引用它的位置都要同步更新：其他 comment 的回复、editor 部分的 integrated points、manuscript、appendix、table 与 note。不能孤立地改一处。
- 描述的points的数目要一致，比如不能出现写 "differ … in two aspects"，后面却列了 First、Second、Third 三点。

---

## 5. Table 呈现

- **Table conventions** [用户] [两者] 按 `shared/table-conventions.md` 逐条检查每张 table：第二阶段不写 fitted label、每张 table 有 significance note、有 dummy 时写明 reference group、跨列变化放在 header、label 清晰但不过度具体

---

## 6. Close-the-case 审查

- **Follow-up triggers** [用户] [单文件] response letter 中可能引发 reviewer 追问、把论文带离主线的地方：与主 story 或 mechanism 不一致的怪 pattern、过多检验技术细节、过于具体而会提醒已知 concern 的描述、超出证据的解读。这类不算错误，一律标 `Needs user confirmation`（策略见 `references/response-strategy.md` `## 战略目标：Close the case`）
