# Lovable → Next.js 迁移与 SEO：标准指南

**[English](../en/convertlovabletonextjs.md)**

本文为 **公开资料与检索整理的实践指南**，不构成采购或法律意见；能力与界面以当期 **Lovable / Next.js / 部署平台** 官方文档为准。

**适用范围：** [Lovable](https://lovable.dev/) 产出的 **浏览器端 Web**：默认 **React + Vite + TypeScript + Tailwind + shadcn/ui**，**不是** Next.js 默认栈。

---

## 导读：本指南写什么、谁先读哪一节

| 读者 | 建议阅读顺序 |
|------|----------------|
| 要 **先做决策**（留 Lovable / 预渲染 / 迁 Next） | **§1 快速决策** → §4（对照表）→ §5（路径） |
| 已决定 **迁 Next**、要落地 Git 与上线 | §3（导出）→ **§6（双仓 + Vercel）** → §7（后端与验收） |
| **非研发**：为何用 Lovable、与主栈如何交接 | §2 |

**约定：** 「**仓 A**」= Lovable 绑定的 **React+Vite** 仓库；「**仓 B**」= 独立维护的 **Next.js** 仓库（如 `project-nextjs`）。

---

## 1. 快速决策

| 你的首要目标 | 推荐路线 | 细节见 |
|--------------|----------|--------|
| **最快产出可演示 UI**，继续在平台里改交互与文案 | **留在 Lovable**（默认 Vite SPA） | §2～§3 |
| **要搜索/社交爬虫读到完整 HTML**，但 **暂不换框架** | **预渲染/DNS 类 SaaS 或自建**（自行选型评估条款） | §5.1 |
| **要强 SEO 约定、混合渲染、与 Vercel 等流水线深度整合** | **迁 Next.js**（技术路径见 **§5.2**） | §4～§6 |
| **必须与主站同仓、同一 CI/CD**（Next/Nuxt 等） | 以 **主栈**为准：React 系多走 Next；Vue 等多为 **重写或架构隔离** | §4 末段 |
| **内部工具、低公网 SEO** | 可沿用 Lovable SPA，仅保持合理路由与 `meta` 习惯 | — |

---

## 2. Lovable：能力定位与适用人群

**典型价值（为何选它）：**

- **对话 + Agent 在多文件生成/修改**：从想法到可点原型时间短，适合做 **PMF 验证页、落地页壳、小规模全栈 POC**。
- **默认 Tailwind + shadcn/ui + Radix**：易出规整界面，模型输出相对稳定；可先掌握其套路以降低「通用 AI 站」观感。
- **Visual Edits（官方）**：在预览中选 DOM 微调样式/Tailwind class，与源码 **双向同步**，适合 **设计/PM 少写代码**的精修。（链接见 §8）

**非研发与公司主站的衔接：** 设计、内容、增长类角色常在 **不写本地工程**的情况下产出可演示版本；一旦要 **并进主域名、同一设计系统与同一条发布流水线**，就会出现 **迁框架或重写**的需求——与下文 **§4 组织动机**、**§6 双仓**一致。

---

## 3. 事实层：官方栈、Next 支持与代码导出

在读动机与迁移步骤前，先对齐 **默认交付形态**：

| 议题 | Lovable 公开结论 |
|------|-------------------|
| **默认前端栈** | React + Vite + TypeScript + Tailwind + shadcn/ui + Radix UI 等（FAQ） |
| **是否默认 Next** | **否** |
| **需要 Next 时** | （1）**导出后迁移**；（2）对话中明确要求 Next，**可能**适配（因项目而异） |

**导出与 GitHub：**

| 项 | 说明 |
|----|------|
| **同步方式** | 连接 GitHub：**密钥不落库**，环境与密钥需在本地/CI **自行配置** |
| **代码归属** | 生产向 React/TS 代码归用户（以 Code Export FAQ 为准） |

**链接：** [Next 支持 FAQ](https://lovable.dev/faq/capabilities/tech-stack/lovable-nextjs-support) · [Tech stack](https://lovable.dev/faq/capabilities/tech-stack) · [Code export](https://lovable.dev/faq/code-export/export-project-code)

---

## 4. 为什么要迁 Next.js？

Lovable **仍是可维护的 React 代码库**；**Next.js** 是在此之上的 **React 全栈框架**（主推 **App Router**）。迁移通常不是为了「换掉 React」，而是在 **相近心智模型**下，换成 **更符合公网站点与团队工程惯例**的运行与构建方式。

### 4.1 技术对照（Vite SPA 典型 vs Next）

| 维度 | Lovable 默认（Vite + CSR 为主） | Next.js（App Router）常带来的增益 |
|------|-----------------------------------|--------------------------------------|
| **SEO / 分享预览** | 首发多为 **轻 HTML + bundle**，主要内容常待 JS 执行 | 可按路由选用 **SSR/SSG/ISR**；**Metadata API** 管理 title、canonical、OG 等 |
| **首屏与数据** | 易出现 **客户端串行 waterfall**（如 `useEffect` 后再请求） | 数据可取到 **服务端/构建阶段**；配合 `next/image`、`next/font` 等减负 |
| **上线工程** | 自建预渲染/CDN/Headers 拼凑 | **统一构建、路由惯例、ISR、middleware、路由级 Loading/Error** 等开箱程度更高 |
| **协作范式** | 偏「单页应用」心智 | **Server / Client Components 分界**、`app/` 文件系统路由、嵌套 layout |

**精读官方对照：** SPA → Next 的迁移语义与 CSR 对照，优先读 [从 Create React App 迁移](https://nextjs.org/docs/app/guides/migrating/from-create-react-app)；App Router 总览：[App Router 文档入口](https://nextjs.org/docs/app)。

### 4.2 组织与流程动机（不止是 SEO）

多数团队迁出平台的直接原因是：**从「孤岛原型仓」进入「主产品同流水线」**。

| 诉求 | 含义 |
|------|------|
| **Monorepo / 设计系统** | 共用 Token、组件，避免两套主题 |
| **同一 Code Review / 预览环境** | 非研发阶段的页面须变成 **可审查 PR** |
| **主站已是 React + Next** | **React+Vite → Next** 属同生态收敛，迁移成本相对较低 |
| **主站为 Vue+Nuxt / 其他栈** | 通常 **不能直接「微调合并」**：多走 **重写、iframe/微前端或子域**；请勿假设存在通用一键转换 |

**结论：** 是否迁 Next **= 产品与 SEO + 组织对主栈/流程的约束** 的合成决策；单靠「框架名声」不值得迁。

---

## 5. 路线选择：预渲染 vs 三条迁 Next 路径

### 5.1 不迁框架：预渲染/DNS（折中）

**适用：** §1 中「先要爬虫可读 HTML、暂不拆仓库」。做法多为：对 **爬虫/弱 JS** 的请求返回 **已执行后的 HTML**，真实用户可走原 SPA。**非 Lovable 官方能力**——须自行选型、读条款、评估 Bot 判定与 SLA。自建替代方向包括各类边缘/Prerender 方案；**本篇 §8 不收商业预渲染网址**。

### 5.2 路径 A～C（既已决定换框架）

| 路径 | 做法 | 注意 |
|------|------|------|
| **A** | **在 Lovable 对话内**明确要求 Next.js + App Router | 与模型强项（Vite + React Router）可能错位，需 **严格验收构建与路由** |
| **B** | **第三方 CLI/托管迁移**（品牌名常为商业产品） | **非** Lovable/Vercel 官方；必读对方文档与安全/计费；§8 **不收**此类链接 |
| **C** | **手工迁移**（团队或 Cursor 等 Agent 辅助） | 可控性最高；下表为核心映射 |

**手工迁移要点（路径 C）：**

| 迁移点 | 方向 |
|--------|------|
| 路由 | React Router → `app/` **文件系统路由** |
| 导航 | → `next/link`、`useRouter`、`usePathname` |
| RSC | 浏览器 API / hooks 放入 **`"use client"`** 边界内 |
| 数据 | `useEffect` 链 → Server Component / Route Handler / 客户端缓存方案 |
| 环境变量 | `VITE_*` → `NEXT_PUBLIC_*` / 服务端专用命名 |
| 构建 | `vite.config` → `next.config`，静态资源与 public 惯例对齐 |

详尽 API 仍以 **§8** 中 [CRA→Next](https://nextjs.org/docs/app/guides/migrating/from-create-react-app)、[Layouts & Pages](https://nextjs.org/docs/app/getting-started/layouts-and-pages) 为准。

---

## 6. 执行手册：双仓 Git · 本地 Agent · Vercel

**本节前提：** 已在 **§5** 选定 **路径 A～C** 之一，且实际需要 **在本机/Git 仓库**里完成 Next 工程（通常为 **手工迁移 C**，或等价迁出物）。本节解决：**不覆盖仓 A**，让 Lovable **继续可用**。

### 6.1 为何双仓（原则）

| 原则 | 说明 |
|------|------|
| **不动 Lovable 绑定的远端** | 覆盖或强改默认分支 history，易导致 **平台与 GitHub 状态不一致**，或阻断他人 **继续在 Lovable 里 Visual Edit** |
| **仓 B 只管 Next** | 例如 **`project-nextjs`**：与原 SPA **产品意图对齐、架构分叉** |
| **可简化为单仓** | 若已不再需要平台写回，可评估 **单仓多分支**，本文仍以 **双远程/双仓**为推荐范式 |

### 6.2 推荐步骤（按顺序执行）

1. **Lovable 内：** 建好项目并 **接通 GitHub** → 得到 **仓 A**（与 §3 Code export 一致）。配置好业务所需的 **远端密钥之外**的运行期 env（密钥只在你的环境）。
2. **本地：** `git clone` **仓 A** → 确认 **Vite 可跑**。大改与迁 Next **勿直接污染 Lovable 仍依赖的默认分支**；宜用 **分支、或单独工作目录**，再收口为 Next 仓库。
3. **按 §5** 产出可 **`next build`** 的工程；可用 **Cursor 等 Agent** 批量改写路由与 **`"use client"`** 边界，**人工**负责对关键路径与设计稿做对拍。
4. **GitHub 新建空仓库** **仓 B** → 在 Next 根目录：`git remote add origin <仓B>`（若曾绑定仓 A，`git remote rename origin lovable` 再 `add origin <仓B>` 亦可）；**只对仓 B `push`**。**禁止**对已绑定 Lovable 的仓 A 做误操作 **`push --force`**。
5. **Vercel：** Import **仓 B**，Framework **Next.js**，环境与分支策略按团队规范。（[Deploying](https://nextjs.org/docs/app/getting-started/deploying)）

### 6.3 Lovable ⇄ Next 的长期对齐（非自动）

- **产品层约定**：谁先改文案/路由，避免双线长期漂移。  
- **工程层**：周期性 diff **路由清单与关键页**；小改动可考虑 cherry-pick 或手抄。**无等价于「同源双构建」的官方同步**。  
- **收敛**：不再需要 Lovable 写代码时，可将 **仓 B 升格为主仓**，或迁入公司 monorepo。

---

## 7. 后端、环境变量与上线验收

### 7.1 后端与绑定（仅用 Lovable Cloud / Supabase 时）

**只换前端仓库不会自动搬走**数据库、Auth 用户、Storage、Edge Functions。典型动作包括：确认 **同一 Supabase 项目**（或新项目的迁移策略）→ 更新 **客户端 env**（URL、anon key 等）→ 跑 **migrations** → 数据/文件迁移 → **OAuth / Magic Link 的 redirect URL** 增加 Next 的正式域与 Vercel 预览域。

### 7.2 检查清单（迁 Next + 双仓上线前建议勾选）

**配置**

- [ ] `NEXT_PUBLIC_*` 与 **仅服务端**变量分离；无密钥进仓库  
- [ ] Supabase / 第三方 Auth 的 **Redirect URI / Site URL** 含生产与预览环境  
- [ ] CORS（若有自托管 API）允许新前端域  

**前端与 SEO**

- [ ] `pnpm build` / `npm run build` 通过；Production 无异步报错  
- [ ] 核心业务路径 **与新路由**逐一验证（对照原 SPA）  
- [ ] 模板级 **metadata**（title、描述、canonical、OG）在关键路由可辨  
- [ ] `next/image` 远端域名、`font`、布局 CLS 目视无明显问题  

**协作**

- [ ]团队知悉 **仓 A 仍为 Lovable 真相源**（若继续用平台）；避免向仓 A 推 Next-only 大改

---

## 8. 参考文献（仅限官方 URL）

本表仅列 **Lovable** 与 **Next.js（Vercel 文档）**；第三方教程、商业迁移工具与预渲染站点 **不收录**。

| 主题 | URL |
|------|-----|
| Lovable Tech stack / FAQ | https://lovable.dev/faq/capabilities/tech-stack |
| Lovable：Next.js 支持 | https://lovable.dev/faq/capabilities/tech-stack/lovable-nextjs-support |
| Lovable：代码导出 | https://lovable.dev/faq/code-export/export-project-code |
| Lovable Blog：Introducing Visual Edits | https://lovable.dev/blog/introducing-visual-edits |
| Lovable Blog：Visual Edits 技术叙事 | https://lovable.dev/blog/visual-edits |
| Lovable Docs：Visual edits | https://docs.lovable.dev/features/design |
| Next.js：App 路由入口 | https://nextjs.org/docs/app |
| Next.js：Layout 与 Pages | https://nextjs.org/docs/app/getting-started/layouts-and-pages |
| Next.js：Server 与 Client Components | https://nextjs.org/docs/app/getting-started/server-and-client-components |
| Next.js：Metadata 与 OG | https://nextjs.org/docs/app/getting-started/metadata-and-og-images |
| Next.js：Image | https://nextjs.org/docs/app/getting-started/images |
| Next.js：Font | https://nextjs.org/docs/app/getting-started/fonts |
| Next.js：从 Create React App 迁移 | https://nextjs.org/docs/app/guides/migrating/from-create-react-app |
| Next.js：Deploying | https://nextjs.org/docs/app/getting-started/deploying |

---

**交叉引用：** 平台对比与默认栈总表见 [`Vibe-Coding产品前端技术栈.md`](./Vibe-Coding产品前端技术栈.md)。
