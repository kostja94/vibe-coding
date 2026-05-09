# Vibe Coding 资源库：AI 建站产品前端技术栈 · Lovable 迁移 Next.js

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/kostja94/vibe-coding?style=social)](https://github.com/kostja94/vibe-coding/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/kostja94/vibe-coding)](https://github.com/kostja94/vibe-coding/commits/main)

**本仓库做什么：** **双语**、**人工整理**的 **Vibe Coding / AI App Builder** 参考资料，面向在 **浏览器中交付的网站与 Web 产品**——汇总各产品的 **React / Vite / Next.js** 等**默认或可导出栈**，另附 **将 Lovable 导出工程迁到 Next.js**、兼顾 **SEO** 与 **双 Git 仓**的实践指南。内容为官方文档与可查公开材料的综述；技术上始终以你仓库里的 **`package.json` 与各配置文件**为准。

**维护者 [@kostja94](https://github.com/kostja94)** · 英文主页 **[English README](README.md)** · 与 **[marketing-skills](https://github.com/kostja94/marketing-skills)** 配套可做 SEO「技能库」 · zyjstc@gmail.com

---

## 目录

- [适合谁](#适合谁)
- [包含什么](#包含什么)
- [文档导航](#文档导航)
- [文档命名](#文档命名)
- [常见问题](#常见问题)
- [范围说明与新鲜度](#范围说明与新鲜度)
- [相关项目](#相关项目)

---

## 适合谁

| 情境 | 可从这里得到 |
|------|----------------|
| 在 **Lovable、v0、Bolt、Replit Agent、Base44** 等产品间做选型或对比 | 一张总览表：**典型栈** vs **导出后请以仓库为准**。 |
| 用 Lovable（默认常为 **React + Vite**）却需要 **SSR / SEO / 分享预览** | 厘清路线：**留在 SPA / 自建或第三方预渲染 / 迁至 Next.js**，以及 **双仓**注意事项与 **Vercel** 部署要点。 |
| 增长与工程要统一 **营销站 + AI 生成的代码仓** | 可对齐技术栈选型，再结合下方 **marketing-skills** 做站内 SEO、落地页模板等。 |

---

## 包含什么

| 文档 | 主要内容 |
|------|-----------|
| [Vibe Coding 产品前端技术栈 · 中文版](docs/zh/Vibe-Coding产品前端技术栈.md) | 国际 / 国内产品，**仅以 Web 为主线**的范围说明，附有官方或可核来源链接。 |
| [迁移 Lovable 至 Next.js（含 SEO · 中文版）](docs/zh/迁移Lovable至Nextjs.md) | **仓 A / 仓 B**、Next **App Router**、**Metadata**、上线前检查清单；参考文献 **仅限官方 URL** 的策略与英文版一致。 |
| 对应的 **英文镜像**见 [English README · Quick navigation](README.md#quick-navigation) ，路径：`docs/en/`。 |

---

## 文档导航

| 用途 | English | 中文 |
|------|---------|------|
| **产品默认 / 典型前端栈**对照 | [vibe-coding-product-frontend-stack.md](docs/en/vibe-coding-product-frontend-stack.md) | [Vibe-Coding产品前端技术栈.md](docs/zh/Vibe-Coding产品前端技术栈.md) |
| **Lovable → Next.js**、SEO、双仓 | [convert-lovable-to-nextjs.md](docs/en/convert-lovable-to-nextjs.md) | [迁移Lovable至Nextjs.md](docs/zh/迁移Lovable至Nextjs.md) |

---

## 文档命名

`docs/en/` 下的英文 Markdown 文件名采用 **kebab-case**：**单词与小写专有片段之间用短横线**，例如 `convert-lovable-to-nextjs.md`、`vibe-coding-product-frontend-stack.md`，避免 `convertlovabletonextjs` 这类黏连_slug，也与 **`kostja94/marketing-skills`**（可读 slug、稳定链接）的实践一致。

`docs/zh/` 可使用 **UTF-8 中文文件名**；中英文成对稿件以主题为纲互链。

**全文规范：** [`docs/meta/document-naming.md`](docs/meta/document-naming.md)（主要为英文执笔，条目含中文说明）。

---

## 常见问题

### 「Vibe Coding」在本文库里指什么？

指用 **对话 / Agent** 快速生成或迭代 **Web 前端**（及附带全栈胶水代码），交付物主要在 **浏览器**中访问。文末 **不包含**或以「范围外」标注 **原生 App 优先、小程序宿主优先**的路线。

### 能替代官网文档吗？

**不能**。本库是 **综述与导航**；产品上「默认模板」「脚手架」会迭代，请以 **当期官方文档** 与实际 **导出代码**为准。

### 我更关心站内 SEO / 着陆页范式，不关心栈表格。

请使用 **[marketing-skills](https://github.com/kostja94/marketing-skills)**：面向 Agent 的 **Markdown 技能**（如 SEO 策略、`title`、`description`、结构化数据、`landing-page` 等）。安装示例：`npx skills add kostja94/marketing-skills`。

### 中英文会像「同一本书」的两版吗？

在结构上 **尽可能对齐**，便于中英文读者或 Agent 对照；小节标题字面可能因语言习惯微调。

---

## 范围说明与新鲜度

- **收录主线：** SSG / SPA / SSR 等与 **公开发表的 Web 技术路径**相关内容。
- **刻意不收：** 对各商业「一键迁框架」工具的枚举、非官方迁移广告链；正文内对 **参考文献**的策略与英文迁移指南保持一致。
- **更新节奏：** 每篇文末有「整理日期 / Last curated」，若某产品 **更改默认脚手架**，欢迎 **PR / Issue** 指出并附上官方出处。

---

## 相关项目

| 仓库 | 作用 |
|------|------|
| [marketing-skills](https://github.com/kostja94/marketing-skills) | **SEO / 内容 / 广告 / GEO / GitHub-parasite** 等成套技能 Markdown，可与本库「栈选型 + 迁移」衔接。 |

**联系：** 问题、勘误、或与此参考配套的新工具？欢迎 **[邮件联系](mailto:zyjstc@gmail.com)**。

---

## 许可证

**MIT**，见 [LICENSE](LICENSE)。

若本篇节省了你的调研成本，点个 **Star** 会有助于他人发现本项目，感谢支持。
