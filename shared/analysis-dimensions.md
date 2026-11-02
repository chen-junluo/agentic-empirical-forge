# 分析维度与调参规范（全局）

> 适用于：AEF02_identify、AEF03_extend 的 Data Analyst Agent

---

## 1. 因变量（Dependent Variable）

因变量可以有两种基本形态，视数据结构和研究问题选择：

- **计数形式（Count）**：直接使用原始数目，如帖子数、回复数、事件次数。
- **比例形式（Proportion）**：将计数除以合适的分母，转化为比例。使用前需确认该比例在经济或行为意义上是有意义的（例如，某类回复占总回复的比例，而非任意分母）。

两种形式均可作为主分析或稳健性检验的因变量，视情况互换使用。

---

## 2. 自变量（Independent Variable）

核心自变量可以有两种编码方式：

- **连续型（Continuous）**：保留原始数值或经对数变换后的值，捕捉线性关系。
- **Dummy / Indicator 型**：将自变量二值化（如以中位数或某阈值为界），用于检验是否存在离散跳跃效应，或当连续型假设不合理时作为替代。

主分析中选定一种后，另一种可用于稳健性检验。

---

## 3. 稳健性检验或补充分析中的变量处理

在主分析之外，对控制变量或自变量可尝试以下处理方式：

### (a) 固定效应化（Factor / Dummy Saturation）

原本作为连续变量加入的控制变量，隐含线性关系假设。可将其转化为固定效应，即对该变量的每一个取值设置 Dummy，完全吸收其影响：

```r
# 原始：连续控制变量
felm(y ~ x + control_continuous | FE | 0 | 0, data = df)

# 替代：将 control 固定效应化
felm(y ~ x | FE + control_continuous | 0 | 0, data = df)
# 或用 factor() 显式展开
felm(y ~ x + factor(control_var) | FE | 0 | 0, data = df)
```

适用场景：怀疑控制变量与因变量之间存在非线性关系，或希望更彻底地控制该维度的混淆。

### (b) 分段处理（Binning）

查看变量的分布（histogram 或 quantile），根据分布形态将其切分为若干段，每段设为 Dummy：

```r
# 查看分布
hist(df$control_var)
quantile(df$control_var, probs = seq(0, 1, 0.25))

# 切分为 3 段（示例）
df$control_bin <- cut(df$control_var, breaks = 3, labels = FALSE)

# 切分为 4 分位数段
df$control_quartile <- ntile(df$control_var, 4)
```

分段数量参考：2、3、4、5 段，视分布形态和样本量决定。分段后将各段 Dummy 加入回归，或将最低段作为基准组。

---

## 4. 聚类标准误（Clustered Standard Errors）

尝试不同的固定效应组合与聚类层级，以检验结果的稳健性：

```r
# 不同 FE 组合
felm(y ~ x + controls | FE1 | 0 | 0, data = df)
felm(y ~ x + controls | FE1 + FE2 | 0 | 0, data = df)

# 不同 Cluster Level
felm(y ~ x + controls | FE | 0 | cluster_var1, data = df)
felm(y ~ x + controls | FE | 0 | cluster_var2, data = df)

# 双向聚类
felm(y ~ x + controls | FE | 0 | (cluster_var1 + cluster_var2), data = df)
```

常见聚类层级：个体、时间单位（天/周/月）、地区、平台类别等，视数据结构选择最合理的层级。

---

## 5. 控制变量（Control Variables）

尝试不同的控制变量组合，但所有加入的变量必须是 **Good Control**（即不受处理变量影响的前定变量，或理论上应控制的混淆因素）：

```r
controls_base   <- "ctrl1 + ctrl2"
controls_full   <- "ctrl1 + ctrl2 + ctrl3 + ctrl4"
controls_parsimonious <- "ctrl1"

# 逐步加入，观察系数稳定性
felm(y ~ x | FE | 0 | cluster, data = df)
felm(as.formula(paste("y ~ x +", controls_base, "| FE | 0 | cluster")), data = df)
felm(as.formula(paste("y ~ x +", controls_full, "| FE | 0 | cluster")), data = df)
```

**注意**：避免加入 Bad Control（即受处理变量影响的中间变量），否则会引入对撞偏误（collider bias）。
