# User-Specific Rules 机制说明

每个 agent 文件末尾有 `## User-Specific Rules` 段落，指向同目录的 `.local.md` 文件。`.local.md` 被 gitignored，用于存放私有规则、偏好和项目特定配置，不会提交到公开仓库。

---

## 使用方法

在 agent 目录下创建对应的 `.local.md` 文件，写入你的规则。Agent 执行时自动读取，冲突时以 `.local.md` 为准。

```markdown
# User-Specific Rules for Writer Agent

- 使用美式英语拼写
- 表格标题用 Title Case
- 敏感字段用 `[REDACTED]` 占位
- DOI 链接用 `https://doi.org/`
```

文件结构示例：
```
AEF01_explore/agents/
├── writer.md               # 公开定义
├── writer.local.md         # 私有规则（gitignored）
```

`git pull` 更新时，公开的 `*.md` 会更新，你的 `.local.md` 完全不受影响。Symlink 安装时，`.local.md` 跟随本体目录，所有链接项目共享规则。

---

## 安全保障

Pre-commit hook（`.github/hooks/pre-commit`）会阻止提交 `*.local.md` 文件或在 agent 文件的 `## User-Specific Rules` 段落后添加实质内容。

首次 clone 后启用 hook：
```bash
git config core.hooksPath .github/hooks
chmod +x .github/hooks/pre-commit
```

测试：
```bash
git add AEF01_explore/agents/writer.local.md
git commit -m "test"
# 应看到：❌ Pre-commit check failed: *.local.md files should not be committed
```

---

## 常见问题

- **误提交 `.local.md`**：还没 push 用 `git reset HEAD <file>`；已 push 需 `git rm --cached` 并 force push
- **规则不生效**：检查文件名是否匹配 agent 文件名，路径是否正确
- **引用其他文件**：可以，但私有文件记得加 `.gitignore`
- **团队共享规则**：在 `references/` 下创建共享文件，`.local.md` 引用它（`references/` 可提交）
