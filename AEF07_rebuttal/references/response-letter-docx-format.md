# Response Letter Word 格式模板（Response Letter Docx Format）

> 适用于：AEF07_rebuttal 中所有产出或修改 response letter `.docx` 的 agent（`response-letter-writer`、`response-polisher`，以及按用户要求直接改 letter 的任务）。本文件只管 Word 版式与 docx 操作；内容结构见 `templates/response-letter-template.md`，语气见 `references/response-polishing-guide.md`。
> 基准样本：MSOM round 1 的 `MSOM_ResponseLetter_261102_updated results.docx`（版式基准），以及 `..._261103_updated results_V2.docx` 的修订经验。

- 维护规则
  - 新增要求：在对应类别下加一个 bullet，开头写一个本文件内不重复的英文短标签（如 **Body style**），agent 按标签引用；条目顺序没有意义，不需要编号
  - 来源标记：`[用户]` = 用户明确要求；`[样本]` = 从基准 docx 提取的实际参数，换期刊或换模板时可改

---
## 1. 文档骨架

- **Page setup** [样本] US Letter（`w:pgSz w=12240 h=15840`），四边 1 inch（`w:pgMar 1440`），页脚放页码
- **Base font** [样本] `Normal` = Times New Roman 12pt、单倍行距；正文统一用自定义 style `Paragraph`（TNR 12pt、黑色、`line=276` 即 1.15 倍）+ 段前段后 6pt（`w:spacing before=120 after=120`）
- **Front matter** [样本] 依次为：
  - 标题 "Response to the Editor and Reviewer Comments"：居中、14pt（`sz=28`）；下一行 manuscript ID 加粗 14pt 居中；再下一行论文题目加粗居中、加引号
  - 致谢段 + revision summary：每类修改用加粗 run-in 小标题（如 **Strengthening Causal Identification:**）+ bullet list，每条末尾标注对应 comment ID（如 `(R1-3, R1-4)`）
  - 结尾段说明编号规则（`DE-X`、`AE-X`、`R1-X`、`R2-X`），并写明 "All substantive changes in the manuscript are highlighted in blue."
- **Section order** [样本] 先 `Response to DE Comments`，再 `Response to AE Comments`；之后插分页符，`Response to Reviewer 1 Comments`、`Response to Reviewer 2 Comments` 各自另起一页；section 标题加粗居中
- **Comment unit** [样本] 每条 comment 按固定顺序排：
  - Comment ID 行：editor 部分用加粗段落（两端对齐、`outlineLvl=0`），如 `DE-1`、`AE-1 (Customization Level)`；reviewer 部分用 `Heading1`，如 `R1-1 (independent variable measurement)`
  - Reviewer 原文：斜体、左缩进 2 字符（`w:ind left=480`）、两端对齐、段前段后 6pt；reviewer 的核心诉求用黄色 highlight 标出，方便逐条核对回应
  - `[Response]` 标签：单独一段，加粗 + 斜体 + 下划线
  - 回复正文：`Paragraph` style；长回复的小节用 `Heading2`（黑色加粗，如 "(a) Our definition and why we adopted it"），不用 `Heading3`（默认是蓝色主题字体）；行内结论用加粗斜体 run-in 标签（如 ***Finding 1: …***）
  - 回复内参考文献：单独一段加粗 "References"（只有一条时写 "Reference"），条目用 `Paragraph`，期刊名斜体
  - 分隔线：comment 之间放一个只含 117 个 `-` 的普通段落（段前段后 6pt），不要用表格或段落边框代替
- **Internal labels** [用户] Comment ID 后括号里的内部备注（如 "(clt-level …)"、"(more answering?)"）只供起草时用，投稿前删掉，或改成 reviewer 能看懂的短标题
- **Text conventions** [用户]
  - manuscript 位置未定稿时一律写占位符（`Section X`、`Appendix [Y]`、`Table [X]`、`p. X`），即使原文写了具体编号也改回占位符，定稿后统一回填
  - 变量名在正文和表格里写法一致：斜体，下标用 subscript（如 *gift*<sub>*j*</sub>、*scripted*<sub>*j*</sub>）
  - 中文例句先给原文，后面括号给英文翻译
  - 同一篇文献在不同 comment 的 References 里，期刊、卷期、页码必须完全一致

---
## 2. 表格版式

- **Caption** [样本] 表题单独成段放在表格上方，`Paragraph` + 段前段后 6pt + 居中 + 加粗；按 comment 编号，如 `Table R1-3-2.`、`Table AE-2-1.`，全文统一用句点（不要混用冒号）
- **Three-line table** [样本] 表格属性：`tblW 5000 pct`、`jc center`、`tblLayout fixed`；不设表级边框（`tblBorders`）和单元格间距（`tblCellSpacing`）；线条全部由单元格边框（`tcBorders`）实现：
  - 首行上边框 1.5pt（`sz=12`）
  - `Controls` 行上边框 1pt（`sz=8`）；最后一个 FE 行下边框 1pt（`sz=8`）
  - 末行（`Num. obs.`）下边框 1.5pt（`sz=12`）
  - 其余单元格四边 `nil`
- **Regression rows** [样本] 行的顺序：
  - 列号行 `(1) … (k)`
  - 可选的 estimator 行（`OLS` / `2SLS` → `first stage` / `second stage`）
  - `DV:` 行：标签右对齐，DV 名斜体带下标
  - 每个变量占两行：系数行带星号，下面一行是括号里的 SE，变量名单元格纵向合并（`vMerge`）
  - 然后是 `Controls`、`Physician FE`、`Date FE`（填 Yes），最后是 `Num. obs.`（千分位）
  - 显著性符号：`*** p<0.001`、`** p<0.01`、`* p<0.05`、`† p<0.10`
- **Cell text** [样本] 回归表 11pt（`sz=22`），数字居中、单元格垂直居中、表内不加粗；文字为主的汇总表用 10pt（`sz=20`），表头居中加粗，正文左对齐，段前段后 2pt（`spacing 40`）
- **Label match** [用户] 表内的行名、DV 名与正文定义完全一致（如正文是 Directive / Rapport-building，表里就不能写 Action / Relational support）；各表 DV 写法统一（如统一用 *gift*<sub>*j*</sub>，不用 "Patient gifting"）
- **Pasted tables** [样本] 从网页或 LLM 输出粘贴来的表格通常是 auto 宽度、`tblCellSpacing 15`、只有表级上下边框，必须按上面的三线表重设

---
## 3. 常见格式偏差与统一做法

- **Normal (Web)** [样本] 从浏览器或 LLM 粘贴的段落会带 `NormalWeb` style 和 `beforeAutospacing` 自动间距（261103 版有 100 多段），统一改成 `Paragraph` + 段前段后 6pt；同一段落如果在基准版本里已有格式，直接沿用基准格式
- **Heading level** [样本] 回复内小节统一用 `Heading2`，发现 `Heading3` 就改
- **Numbering** [样本] 同一组小节要么全用自动编号，要么全用手写 "(a)/(b)"，不要混用（如 "(a)" 是自动编号、下一段却写 "Part 2:"）；统一时把前一段的 `numPr` 复制过来
- **Captions** [样本] 表题常见三种混杂写法（`TableFiguretitle`、`NormalWeb`、普通段落），按 §2 **Caption** 统一
- **Format tracking** [用户] 默认只有文字修改记 track changes，格式统一直接改、不留修订，避免几百条 "Formatted" 批注干扰合作者审阅；用户要求时才用 `pPrChange`
- **Pandoc artifacts** [样本] pandoc 转出来的 `$$` 空公式，是别人已删除的 `m:oMath` 修订残留，在 Word 里看不见，不用处理

---
## 4. 修改既有 letter 的 docx 工作流

- **Versioning** [用户] 不覆盖原文件：复制为 `<原文件名>_V2.docx` 再改；修订作者用用户指定的名字（如 `Junluo CHEN`），并把该作者加进 `word/people.xml`
- **Read first** [样本]
  - 当前文本用 `pandoc --track-changes=accept -t markdown --wrap=none`
  - 合作者 comment 从 `word/comments.xml` + `commentsExtended.xml`（`w15:done`）提取，连同锚定文本一起列出，用来判断哪些还没解决
  - 拿合作者批注版和当前版逐条对照：comment 删掉了但问题还在的，也要报告
- **Edit rules** [样本]
  - 用 docx skill 的 `unpack.py` 解包；按"接受修订后的文本"定位（跳过 `w:del` 里的 run），匹配前统一弯引号
  - 行内公式 `m:oMath` 不计入文本，修改范围不能跨过公式
  - 做词级 diff，只把真正改动的词包进 `w:del` / `w:ins`
  - 要在别人的 `w:ins` 中间插入，先把对方的 `w:ins` 拆开，不要嵌套
  - 整段删除时，在 `pPr/rPr` 里也加 `w:del`
  - 所有修改写进一个脚本，每次从全新解包的副本跑，不要在自己的插入上叠加修订
- **Pack pitfalls** [样本]
  - docx skill 的 `pack.py` 需要 Python ≥ 3.10
  - 它的 `_condense_xml` 只保护 `w:t`，会删掉只含空格的 `w:delText`，结果"拒绝修订"视图里出现 "6, 7,or8" 这类粘连；打包时必须把 `w:delText`、`w:instrText`、`w:delInstrText` 一起保护
- **Verify** [样本] 交付前逐项确认：
  - schema 校验通过，comment 数量不变
  - V2 拒绝全部修订后的文本，与原文件拒绝全部修订后的文本相比，只有格式差异
  - 接受修订后与原文逐段 diff，每段新文字都通读一遍（检查重复括号、语法、残留旧说法）
  - 在 Word 里目视检查改过格式的表格

---
## 5. 投稿前 checklist

- 占位符（`Section X`、`Appendix [Y]`、`Table [X]`、`p. X`）已按定稿 manuscript 回填，`[cite]`、`[Optional …]` 等起草标记已删除
- Comment ID 后的内部备注已删除或改写；合作者 comment 全部处理并删除；track changes 已全部接受
- 决定 reviewer 原文里的黄色 highlight 是否保留（只是自查工具时投稿前去掉）
- 表题编号连续且与正文引用一致，所有表都是 §2 的三线表
- 同一文献在各 References 中信息一致，letter 引用的文献都有对应条目
