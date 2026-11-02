# 因果识别策略清单

> 适用于：Agent 3 (Data Analyst) — Stage AEF03_extend

---

## 选择识别策略的原则

识别策略的选择取决于数据结构和研究问题。以下是常见策略及其适用条件。

---

## 1. Difference-in-Differences (DID)

**适用条件：**
- 有处理组和控制组
- 有清晰的处理时间点
- 平行趋势假设可辩护

**必须汇报：**
- 平行趋势检验（event study plot）
- 处理前各期系数不显著
- 如有多期处理，使用 Callaway-Sant'Anna 或 Sun-Abraham 估计量

**R 包：** `did`, `fixest`, `staggered`

---

## 2. Instrumental Variables (IV)

**适用条件：**
- 有内生性问题
- 能找到满足相关性和排他性的工具变量

**必须汇报：**
- First stage F 统计量（>10 为弱工具变量警戒线，>100 更好）
- Hausman 检验（内生性检验）
- 工具变量的经济逻辑说明

**R 包：** `ivreg`, `fixest`

---

## 3. Regression Discontinuity (RDD)

**适用条件：**
- 有连续的运行变量（running variable）
- 处理在某个阈值处不连续分配

**必须汇报：**
- McCrary density test（操纵检验）
- 带宽选择（MSE-optimal bandwidth）
- 局部线性回归结果
- 不同带宽的稳健性

**R 包：** `rdrobust`, `rddensity`

---

## 4. Fixed Effects

**适用条件：**
- 面板数据
- 控制不随时间变化的个体异质性

**必须汇报：**
- 固定效应类型（个体 / 时间 / 双向）
- 标准误聚类方式（按个体 / 时间 / 双向）

**R 包：** `fixest`（推荐，速度快）

---

## 稳健性检验菜单

| 类型 | 具体做法 |
|------|---------|
| 替换因变量 | 用不同定义/测量方式 |
| 替换自变量 | 用不同代理变量 |
| 样本限制 | 去掉极端值、特殊子样本 |
| 控制变量 | 逐步加入控制变量 |
| 标准误 | 不同聚类方式 |
| 时间窗口 | 不同估计窗口 |
| 安慰剂检验 | 随机处理时间 / 随机处理组 |
