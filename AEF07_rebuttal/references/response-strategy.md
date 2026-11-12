# 审稿回复策略规范

> 适用于：AEF07_rebuttal 的 `response-planner` agent

---

## 战略目标：Close the case

- 维护规则：本节条目开头写一个本文件内不重复的英文短标签，agent 按标签引用；`[用户]` = 用户原始要求，`[补充]` = 落地说明，用户可删改
- **Close the case** [用户] 最好的 response 是让 reviewer 看完觉得 case closed。不好的 response 是让他意识到有很多细节他不知道、一直追问、让你重做，或者让他觉得里面有些东西很有意思、要你再深挖；这两种都会把论文的路线带偏。
  - [补充] 对每条 comment 制定方案时，先写出这样回会引出哪些 follow-up question（`response-planner` 输出中的 `Follow-up risk`），再决定写多少、写到什么程度
- **Stay on main line** [用户] 明确论文的重点。比如如果有一篇文章重点是是 main effect 与 mechanism；不要单纯因为 reviewer 提了，就把一个 descriptive 的支线问题做成新战场。只有一个 identification 工具时，多变量的支线分析也只能是 descriptive 的，做不出更多东西。
- **Position as exploratory** [用户] 对 minor comment 或超出现有 identification 能力的问题（如多个 content / feature 各自的效果），在该条回复开头的"帽子"段先定性：reviewer 自己也说是 minor；我们做了分析；因为某些原因（e.g., 只有一个 instrument，无法 estimate 这些多个自变量的 causal effects)，结果是 exploratory / suggestive 的；更 definitive、confirmatory 的答案需要 randomized experiment。先打招呼，让 reviewer 从头到尾都把它当成 minor，不再纠结。
- **No odd patterns** [用户] 报告的结果里不要有特别奇怪、让人不由自主想追问的地方；结果 pattern 应与文章的主 story 和 mechanism 对得上。
- **Don't over-clarify** [用户] table 和文字改得清楚是好事，但有些地方我们不希望 reviewer 去想；描述与正文定义保持同一层级，不要因为写得过于具体而提醒 reviewer 想到已知的 concern（见 `shared/table-conventions.md` **Label restraint**）。
- **Placement signals role** [用户] 新增分析在 manuscript 中的位置本身就是定位。主分析的扩展（如放宽 treatment 定义，看效果是否不同）放在 mechanism 之前，用问题式的 section title（如 "Does X also play a role?"），并写清它的 theoretical implication；不要简单地放在 mechanism 之后当成 additional analysis，否则读者会觉得在探讨原因之后又回头放宽定义，还会追问 mechanism 是否仍然成立。
  - [补充] `response-planner` 输出中的 `Manuscript placement` 记录每项新内容放在哪一节、以什么定位出现

---

## 四种回复策略

### [策略: 争取]

**适用场景：** Reviewer 提出了实质性质疑，但可以通过补充分析或论证来说服。

**执行要点：**
- 先具体点出这条 concern 的实质（不评价 comment 本身，见 `references/response-polishing-guide.md` **No evaluating comments**）
- 提供新的分析结果或论证
- 用数据说话，不空谈
- 示例："Thank you for raising the concern about [X]. To address it, we conducted additional analysis..."

### [策略: 安抚]

**适用场景：** Reviewer 给了建设性建议，或指出了确实存在的小问题。

**执行要点：**
- 真诚感谢
- 说明已按建议修改
- 指出修改位置（页码/段落）
- 示例："Thank you for the suggestion to clarify [X]. We have revised Section X accordingly..."

### [策略: 坚守]

**适用场景：** Reviewer 的要求不合理（超出论文范围、方法论上不可行、或基于误解）。

**执行要点：**
- 礼貌但坚定
- 解释为什么不做这个修改
- 提供文献支持你的立场
- 绝不攻击 Reviewer
- 不直接说对方错，按 examine → result → explanation 叙事（见 `references/response-polishing-guide.md` **Examine then explain**）
- 示例："Following your suggestion, we examined [X]. The results show [Y]. One possible explanation is [Z], which is consistent with [Author, Year]."

### [策略: 让步]

**适用场景：** 修改成本低，且修改后确实能改善论文。

**执行要点：**
- 快速执行
- 明确说明修改内容
- 示例："We agree and have made the following changes..."

---

## Reviewer 立场判断

| 立场 | 信号 |
|------|------|
| 支持 | 整体正面评价，comments 以"建议"为主，用词如 "interesting", "well-written" |
| 中立 | 有实质性问题但态度客观，用词如 "the authors should consider", "it would be helpful" |
| 反对 | 质疑核心贡献或方法论，用词如 "fundamental concern", "not convinced", "major weakness" |

## SE/AE 关系管理

- 开头：感谢 SE/AE 的时间和指导，表达对修改机会的珍视
- 结尾：总结主要修改，表达期待
- 如果 Reviewer 之间有矛盾意见：在给 AE 的信中明确说明你的选择和理由
