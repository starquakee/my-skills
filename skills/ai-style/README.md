# ai-style

中文文案去“AI 味”检查清单。规则由用户对生成文本的 before/after 纠正反馈提炼，适用于中文产品稿、公众号文章、邮件和 README 等面向读者的内容。

来源：[bojieli/ai-agent-book](https://github.com/bojieli/ai-agent-book/tree/main/chapter9/ai-style-skill/skill)，原项目采用 [Apache License 2.0](https://github.com/bojieli/ai-agent-book/blob/main/LICENSE)。本目录保留原 Skill 内容，仅补充来源说明。

## 安装

Codex：

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \\
  --repo starquakee/my-skills \\
  --path skills/ai-style
```

Kimi Code：

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \\
  --repo starquakee/my-skills \\
  --path skills/ai-style \\
  --dest ~/.kimi-code/skills
```

重启或新开 Codex/Kimi Code 会话后生效。
