# R 脚本规范（全局）

> 适用于：AEF02_identify、AEF03_extend 的 Data Analyst Agent

---

## 包管理习惯

不使用独立的 `deps.R`，直接在脚本顶部 `library()` 加载所有需要的包。常用包组合：

```r
library(readr)
library(lfe)          # felm() 固定效应回归（主力，非 fixest）
library(fixest)       # 备用
library(texreg)       # screenreg() / texreg() 输出
library(stargazer)    # 备用表格输出
library(sandwich)
library(broom)
library(dplyr)
library(tidyverse)
library(stringr)
library(ggplot2)
library(ggpubr)
library(haven)        # read/write .dta
library(data.table)
library(janitor)
library(MatchIt)
library(timeDate)     # 节假日处理
library(forcats)
library(huxtable)
library(robomit)
library(mediation)
```

---

## 脚本结构

单文件脚本为主，按分析逻辑分段，用注释块分隔：

```r
# ============================================================
# Section Title
# ============================================================
```

无强制文件命名约定，文件名直接反映项目和版本，如 `projectA_JOURNAL_round2_YYMMDDR.R`。

---

## 数据读取

使用绝对路径（本机路径），`read_csv()` 为主：

```r
mydata <- read_csv("/path/to/your/data/...")
```

备用路径用注释保留：

```r
# mydata <- read_csv("/path/to/backup/...")
```

---

## 变量构造习惯

### 封装为函数统一处理

数据清洗和变量构造封装进函数，对多个数据集复用：

```r
update_data_fields <- function(df) {
  df$log_x <- log(df$x + 1)
  # ...
  return(df)
}
mydata_AI      <- update_data_fields(mydata_AI)
mydata_AI_full <- update_data_fields(mydata_AI_full)
```

### 命名规则

| 前缀/后缀 | 含义 |
|-----------|------|
| `log_`    | log(x+1) 变换 |
| `I`       | 二值化指示变量（如 `IimgNum_ask`） |
| `_squared` / `_power2` | 平方项 |
| `_ask` / `_sumResp` / `_1Resp` / `_1Ans` | 数据来源后缀 |
| `_gt1` / `_eq9` | 条件后缀 |

### 赋值风格

变量构造混用 `<-` 和 `=`，两者均可接受：

```r
df$log_x <- log(df$x + 1)
df$flag = ifelse(df$x > 0, 1, 0)
```

### 二值化

```r
df$IimgNum_ask <- as.integer(df$imgNum_ask > 0)
# 或
df$flag = ifelse(df$x > 0, 1, 0)
```

### 缺失值填充

```r
df$var <- ifelse(is.na(df$var), 0, df$var)
```

### mutate() 用于多字段批量构造

```r
mydata_answer <- mydata_answer %>%
  mutate(
    field1 = expr1,
    field2 = expr2,
  )
```

---

## 回归规范

### 主力：`felm()`（来自 `lfe` 包）

固定效应回归统一用 `felm()`，格式：

```r
felm(y ~ x1 + x2 + controls | FE | IV | cluster, data = df)
```

- 无固定效应：`| 0 | 0 | 0`
- 有固定效应（如日期）：`| dayofyear | 0 | 0`
- 控制变量组合固定，每个模型复用同一套 controls

### 模型存入 list

```r
models <- list()
models[["model name"]] <- felm(y ~ x | FE | 0 | 0, data = df)
models[["model2"]]     <- felm(y ~ x + z | FE | 0 | 0, data = df)
```

### 交互项写法

```r
felm(y ~ post * (x1 + x2) + controls | FE | 0 | 0, data = df)
felm(y ~ factor(ansTimeID) * quality + controls | 0 | 0 | 0, data = df)
```

---

## 结果输出规范

### 屏幕预览：`screenreg()`（来自 `texreg`）

```r
print(screenreg(models,
      stars = c(0.1, 0.05, 0.01, 0.001),
      digits = 3, dcolumn = TRUE, threeparttable = TRUE, fontsize = "tiny",
      include.fstatistic = TRUE, include.adjrs = FALSE, include.rsquared = FALSE,
      robust = TRUE,
      include.groups = FALSE, single.row = FALSE,
))
```

### LaTeX 输出：`texreg()`

```r
texreg(models,
       file = "../tables/tab_XX.tex",
       stars = c(0.1, 0.05, 0.01, 0.001),
       digits = 3, booktabs = TRUE, dcolumn = TRUE,
       include.fstatistic = TRUE, include.adjrs = FALSE, include.rsquared = FALSE,
       robust = TRUE,
)
```

**注意：** 不使用 `modelsummary`，主力输出工具是 `texreg` / `screenreg`。

### 显著性星号约定

```
. p<0.1, * p<0.05, ** p<0.01, *** p<0.001
```

对应 `stars = c(0.1, 0.05, 0.01, 0.001)`。

---

## 描述性统计

自定义函数计算分组统计量（全样本、AI组、非AI组），输出 data.frame：

```r
calculate_stats <- function(data, data_AI, data_NoAI, variables) {
  # 返回含 Mean, SD, Min, Max 的 data.frame
}
results <- calculate_stats(mydata_AI, mydata_AI_isAI, mydata_AI_isnotAI, variables)
print(results)
```

---

## 数据导出

导出 `.dta` 供 Stata 使用，变量名需清理至 ≤32 字符：

```r
write_dta(mydata_export, "/path/to/output.dta")
```

---

## 路径约定

- 数据读取：绝对路径
- 表格/图形输出：相对路径（`../tables/`、`../figures/`）或绝对路径均可

---

## 数字引用原则

**论文中的所有数字只从 R 输出文件读取，通过 `\input{}` 引用，不手动填写。**
