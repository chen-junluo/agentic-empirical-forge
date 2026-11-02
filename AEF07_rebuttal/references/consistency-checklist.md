# 一致性检查清单（Consistency Checklist）

> 适用于：AEF07_rebuttal 的 `consistency-checker` agent。本文件是检查项的唯一来源（single source of truth），agent 不另行定义检查项。

- 维护规则
  - 新增检查项：直接在对应类别下追加一条，编号顺延（如 `C2.6`）；新类别则新增 `## 5. ...`，沿用 `C5.x` 编号
  - 来源标记：`[用户]` = 用户原始要求（保留原话）；`[补充]` = 建议新增项，用户可删改，或确认后改为 `[用户]`
  - 每条检查项末尾用括号标注适用模式：`单文件` / `跨文件` / `两者`
- 检查对象与模式
  - 文件：manuscript、response letter、appendix，大概率是 Word（`.docx`）文件
  - 单个文件模式：针对单个文件进行检查，文件可以是 manuscript、response letter，也可以是 appendix
  - 跨文件模式：把多个文件糅合到一起检查，也就是 cross documents、cross materials 的一致性

---

## 1. 数字、样本与设定一致性

- `C1.1` [用户] Sample size 的一致性：包括 regression 的 sample size，以及文章里有关 sample size 的描述。（两者）
  - 检查要点：每张 regression table 的 N、正文 / abstract / data section 描述的样本量、样本筛选流程逐步剔除后的数字、response letter 中提到的 N 互相对得上；不同 table 之间 N 的变化必须有解释（如 subsample、missing values）
- `C1.2` [补充] 关键估计结果的引用一致：正文、abstract、response letter 中引用的 coefficient、standard error、显著性水平、effect size（如 "increases by 12%"）与对应 table 中的数字一致（两者）
- `C1.3` [补充] 描述性数字一致：样本期间（年份范围）、观测单位、公司 / 用户 / 地区数量、mean、percentage 等在不同位置一致（两者）
- `C1.4` [补充] 模型设定描述一致：estimator、fixed effects、clustering level、control variables 在正文方法描述、table notes、appendix 中一致（两者）
- `C1.5` [补充] 结果解读方向一致：同一结果的符号（正 / 负）、显著与否、经济含义在 abstract、introduction、results、conclusion、response letter 中表述不矛盾（两者）

---

## 2. 术语一致性

- `C2.1` [用户] 描述同一个东西时，不要在文章里一会儿用这个、一会儿用那个。（两者）
- `C2.2` [用户] 如果某个概念是 reviewer 提到的，术语尽量以 reviewer 提到的为准，多用原话。（跨文件：reviewer comments ↔ response letter ↔ manuscript）
- `C2.3` [补充] 缩写首次出现时定义，之后统一使用；不在定义前使用、不重复定义（单文件）
- `C2.4` [补充] 变量名一致：同一变量在正文、table、variable definition appendix 中的名称与定义一致（两者）
- `C2.5` [补充] Hypothesis、construct、mechanism 的命名与编号全文一致（如 H1 不在别处变成 H1a，同一机制不换名字）（两者）

---

## 3. Cross-reference 一致性

- `C3.1` [用户] 单个文件内（如 response letter）的交叉引用。最常见的是在某个 reviewer 的 comments（如 R1-2）里提到"参见 R1-4"，那就要核实 R1-4 里是不是真的有 R1-2 所指的内容。（单文件；跨 reviewer 引用如 "see our response to R2-3" 同样适用）
- `C3.2` [用户] 仔细检查 section title、appendix title、table title 以及 page 等信息。（两者）
  - 检查要点：response letter 中写的 "Section 4.2, p. 15"、"Table A3" 等定位信息，与 manuscript / appendix 实际的标题、编号、页码一致，且被引用对象确实存在
- `C3.3` [用户] 正文里 appendix 的顺序要顺下来：正文中第一个出现的必须是 Appendix A，第二个是 Appendix B，需要把 appendix 内部的顺序对应修改过来。（跨文件：manuscript ↔ appendix）
- `C3.4` [补充] Table、figure 按正文首次引用顺序连续编号：无跳号、无重复、无"引用了却不存在"的 table / figure（两者）
- `C3.5` [补充] 文中 citation 与 reference list 一一对应：引用了的都在 reference list，reference list 中的都被引用；作者名、年份拼写一致（单文件）
- `C3.6` [补充] Response letter 中引用的 manuscript 修改原文（quoted revised text）与 manuscript 当前版本逐字一致（跨文件）

---

## 4. 承诺与内容一致性

- `C4.1` [用户] 比如 response letter 或 manuscript 里明明说了做了某些修改或补充，但后面实际没有做、没有披露对应细节，或者根本没写，这种情况也是不行的。（两者，重点是跨文件）
  - 检查要点：逐条核对 response letter 中 "we have added / revised / conducted ..." 等承诺，在 manuscript / appendix 中找到对应内容；manuscript 中 "see Appendix X for details" 指向的位置确有相应细节
- `C4.2` [补充] Comment 覆盖完整：每条 reviewer comment 在 response letter 中都有回应；`revision_tracking.md` 中标为 `DONE` 的项在 manuscript 中可找到对应修改（跨文件）
- `C4.3` [补充] 回应立场一致：对同一问题，回应不同 reviewer 或同一 reviewer 的不同 comment 时，立场与理由不相互矛盾（如对 R1 说"不做"、对 R2 说"已做"）（单文件：response letter）
- `C4.4` [补充] 修订后无残留旧表述：新增分析或新 framing 之后，abstract、introduction、conclusion 等未同步更新的段落不再与新内容冲突（单文件：manuscript）
