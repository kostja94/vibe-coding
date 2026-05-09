# Vibe Coding 产品前端技术栈（网页 / 网站）

**[English](../en/vibe-coding-product-frontend-stack.md)**

本文 **仅覆盖用于构建「在浏览器中访问的网站与 Web 产品」**（SSG、SPA、SSR/PWA Web 等均算）。**不包含** 原生移动端 App（iOS/Android）、微信/抖音等小程序、React Native / Expo **移动壳**；若某平台的宣传重点在上述形态，将 **移出正文表格**或 **标注为范围外**。

本文为 **公开资料与官方说明的整理**，各产品会迭代默认模板与推荐栈；落地前请以各平台当期文档与生成的 `package.json` 为准。

**整理日期：** 2026-05-01；**范围修订：** 2026-05-01（收窄为网页端）

**延伸阅读：** 如果你已选定 Lovable 并需要 SSR / SEO，配套指南覆盖完整迁移路径：[迁移 Lovable 至 Next.js](./迁移Lovable至Nextjs.md)。

---

## 一览表（Web 前端为主）

下表仅限 **可向浏览器交付** 或可导出为 **Web 工程** 的路径；区分 **标准 Web 导出** 与 **托管闭源 / 未见公开前端栈**。  

### A. 国际：对话 / Agent → 浏览器产品（或可导出 Web 仓）

| 平台 | 典型 / 默认前端栈 | 是否「固定栈」 |
|------|-------------------|----------------|
| **Lovable** | React + TypeScript + **Vite** + Tailwind + **shadcn/ui** + Radix UI；路由常为 **React Router** | **偏固定**（官方 FAQ） |
| **v0**（Vercel） | **Next.js**（App Router）+ React + Tailwind + **shadcn/ui** | **默认 Next**（全栈文档推荐） |
| **Replit Agent** | 常见 **React + Vite (+ Tailwind / shadcn)** **用于 Web** | **不固定**（官方：任意框架；若目标仅为网站，须在提示里写死 Next/Vite SPA 等） |
| **Bolt.new** | **按提示任选**；环境支持 **Vite / Next.js / Astro** 等 StackBlitz 可运行栈；starter 常见 **React + Vite** | **按项目可变** |
| **MeDo** | 文稿与站内示例：**React + Vite + Tailwind**（含 v4 描述） | **以导出为准** |
| **Base44** | **React + React Router + Vite + Tailwind + shadcn/ui** | **文档固定描述** |
| **Atoms** | 营销侧重全栈交付；集成页常见 **Supabase / Stripe / GitHub 导出**；**默认 Web 脚手架未在官网逐条写明** | **导出后看仓库** |
| **Trickle** | 自家博客：**React + Tailwind CSS**「在底层使用」（面向用户话术） | **偏固定组合** |
| **Tempo Labs** | YC 资料：**React**，并写明 **optimized for Vite and Tailwind**；SaaS 模板文档可选 **Next.js + Supabase** 等 | **React 核心**；模板可 Next |
| **Create.xyz** | 公开分享的系统提示写明生成 **React + Tailwind** 组件（平台内拼装运行） | **生成规范偏 React/Tailwind** |
| **Firebase Studio**（App Prototyping agent） | 官方：**Next.js** Web 原型与发布（Firebase App Hosting） | **原型路径为 Next.js** |
| **Firebase Studio**（模板工作台） | **只看 Web：** 模板库中含 **React、Next.js、Vue、Angular、Svelte、Astro** 等（官方另含移动端模板，本篇不展开） | **依所选 Web 模板而定** |
| **Framer**（站点构建） | 产品本身是 **React** 生态的视觉建站工具；AI 辅助生成页面仍以 Framer/React 运行时为主 | **Framer/React** |

### B. 国产 / 区域性（Web/H5 / 云上网站方向）

| 平台 | Web 语境下的栈 / 可查信息 | 说明 |
|------|---------------------------|------|
| **百度秒哒（MIAODA）** | **网站 / H5 形态**的官方公开栈 **同样未见逐条白皮书**；第三方常描述为零代码闭环托管 | **宣传中亦含小程序等形态，本文仅从「若在平台内产出可浏览器访问页面」建档**；与海外 MeDo 的 React+Vite 描述 **不可想当然等同** |
| **腾讯云开发 CloudBase · AI Toolkit** | 官方 MCP/文档：**Web 应用集成 React、Vue、Next.js**；社区文章常以 **React + 云函数** 演示 | 云开发套件 **还支持小程序**：**本文只引用其与「Web 前端工程」相关的描述** |

### C. 设计 / 建站向（偏「原型与交付物」，不等同全文栈 Agent Builder）

下列产品也常用于「App 屏」草图；**本篇只关心其链路落到「浏览器内站点 / Web 导出」时的技术表述。**

| 产品 | 常见代码交付形态 | 备注 |
|------|------------------|------|
| **Google Stitch（原 Galileo AI 路线）** | 第三方综述多写：**HTML/CSS + Tailwind**、可导出 Figma；是否/何时包含完整 React 工程需 **以当前 Stitch 导出选项为准** | 归入 **UI 起手 + 导出**，与 Lovable「整仓 GitHub」路径不同 |
| **Uizard** | 以 **可视化屏幕** 为主，再手工或插件对接设计与代码 | 「UI 速写」强于「后端一体」 |
| **Webflow AI / Framer AI** | 各自生态运行时（Framer：**React** 系）；Webflow：**自有 CMS + HTML/CSS 导出规则**复杂 | **强建站 / 内容与动效**，非同类「一页 prompt 生成 Supabase CRUD」 |
| **Magic Patterns、Relume Sites、Banani** 等 | 多篇评测写明 **React + TypeScript + Tailwind** 类「可落地代码导出」能力（以各官网 Export 文案为准） | 与正文全栈托管型产品区分开 |

### D. 收录范围外（非浏览器网站主线）

以下产品在公开叙事中 **常以手机端侧应用、小程序宿主或混合交付为主**，**不满足「本篇仅谈网页建站 / Web 站」**，故 **不进入上表**：

| 名称 | 原因（简述） |
|------|--------------|
| **阿里「灵光」闪应用** | 媒体描述为手机 **端侧可运行** 体验；重点非「导出可在任意域名托管的 Web 源码仓」（延伸阅读：[网易报道摘录](https://www.163.com/dy/article/KQV7RV41051180F7.html)） |
| **纯小程序方案、「小程序优先」的多端平台** | 交付物宿主为小程序运行时（微信等），与本篇浏览器网站范围不符 |

多端（RN / 小程序 / Hybrid）若要单独成篇，建议另立文档以免与 Web 表格混读。

---

## 分平台说明

### Lovable

- **前端：** React、TypeScript、**Vite**、Tailwind CSS、**shadcn/ui**、Radix UI。  
- **路由：** 常见为 React Router（第三方归纳与开源 boilerplate 与官方能力描述一致）。  
- **后端/数据：** 常与 Supabase 等搭配（属全栈范畴，非纯前端）。

**依据：** [Lovable FAQ：What tech stacks does Lovable know?](https://lovable.dev/faq/capabilities/tech-stack/lovable-tech-stack)

**延伸（迁移 / SEO / 双仓）：** 见 [`迁移Lovable至Nextjs.md`](./迁移Lovable至Nextjs.md)。

---

### v0（Vercel）

- **默认：** Next.js（含 App Router、React Server Components 等全栈模式下的默认选型）。  
- **UI：** React + Tailwind CSS + **shadcn/ui** 为典型输出形态。  
- **说明：** 官方文档写明全栈应用时 **默认为 Next.js**；也可要求其他框架，但 **Next.js 通常最可靠**。博客亦强调与 Vercel 部署、SSR/SEO、App Router 的整合。

**依据：**  
- [v0 Docs：Full-stack apps](https://v0.dev/docs/full-stack-apps)  
- [Vercel Blog：How v0 is building SEO-optimized sites by default](https://vercel.com/blog/how-v0-is-building-seo-optimized-sites-by-default)

---

### Replit（Agent / Build）

- **Web 建站视角：** Agent 可把 **浏览器内访问的网站**打成 **任意框架**，但最常见公开案例仍是 **React + Vite（+ Tailwind / shadcn）**；须在任务描述中明确 **SPA、Next、纯静态站**之一，以避免偏到服务端 CLI 或非 Web。
- **与本文范围：** 官方亦宣传移动端等能力 **本文不收录**。

**依据：**  
- [Replit：Agent on any framework](https://blog.replit.com/agent-on-any-framework)  
- [Replit：2025 in Review](https://blog.replit.com/2025-replit-in-review)

---

### Bolt.new（StackBlitz WebContainers）

- **定位：** 浏览器内完整 Node/npm 环境与 AI 编排，可在对话中 **安装依赖、选脚手架**。  
- **前端：** **无单一强制默认栈**；官方 FAQ 写明支持多数流行 JS 框架，**能在 StackBlitz 上跑的通常也可用**。文档与 README explicitly 举例 **Vite、Next.js** 等。  
- **常见起点：** 官方/社区可见 **React + Vite** 起始模板（如 `bolt-vite-react`）。

**依据：**  
- [stackblitz/bolt.new README](https://github.com/stackblitz/bolt.new/blob/main/README.md)  
- [Bolt.new：Vite React Starter（示例入口）](https://bolt.new/~/bolt-vite-react)

---

### MeDo

- **公开描述（Web）：** DEV 等 builder 手记写明 **React + Vite + Tailwind** 的 **Web 工程** 可由平台托管迭代；官网示例亦出现同一技术组合。MeDo 若还提供其他宿主形态 **不在本文展开**。  
- **注意：** 内置后端与插件生态以后端为准；**浏览器端**仍以导出/预览中的 Web 为准。

**依据：**  
- [DEV：MeDo hackathon 手记](https://dev.to/vineetnegi0101/i-built-a-60-second-reflection-app-that-paints-you-a-watercolor-keepsake-day-2-of-the-50k-medo-5065)  
- [MeDo 官网示例](https://medo.dev/)

---

### Base44（与 Lovable 文档级同构）

- **前端（官方文档）：** **React + React Router + Vite + Tailwind + shadcn/ui**。  
**依据：** [Base44：App Code Introduction](https://docs.base44.com/developers/app-code/overview/introduction)

---

### Trickle（trickle.so）

- **公开表述：** 官方博客 **Why Vibe Coding Works** 中写明：*"Trickle uses **Tailwind CSS and React** behind the scenes"*，用户侧以自然语言描述需求为主。  
- **定位：** 一体机（托管、建站、表单/数据、内置 AI 集成等）；与强调 GitHub 导出的工具路径不同。

**依据：** [Trickle blog：Why Vibe Coding Works（React + Tailwind）](https://trickle.so/blog/why-vibe-coding-works-a-guide-for-developers)

---

### Atoms（atoms.dev）

- **浏览器侧：** 用例描述为生成 **可用的网站与应用（Web）**，含 Supabase、导出与托管路径；框架与 Bundler **以导出仓 `package.json` 为准**。  
- **注意：** 与 Atomic.io 等其他「Atomic」品牌无关。

**依据：**  
- [Atoms：App builder use case](https://atoms.dev/usecases/app-and-website-builder)

---

### Tempo Labs（tempo.new / Tempo「视觉 + 代码」）

- **核心栈（网站 / Web 应用）：** Y Combinator 公司简介写明为 **React 的可视化编辑器**，且 **Optimized for Vite and Tailwind**；Mintlify 文档提供 **Next.js + Supabase + Polar** 等 **Web** SaaS 搭建指南。**同名产品亦宣传 Expo 移动能力，本篇不展开。**

**依据：**  
- [Y Combinator：Tempo 公司页（React、Vite、Tailwind）](https://www.ycombinator.com/companies/tempo-2)  
- [Tempo 文档：Next.js + Supabase + Polar](https://tempolabsinc.mintlify.app/Next.jsSupabasePolar)

---

### Create.xyz

- **生成侧约束：** 平台内流传的系统提示范本要求输出 **React + Tailwind**，且组件为函数式 Hooks 风格（属第三方披露的生成规范节选，仍可能迭代）。  

**依据：** [Create.xyz 分享页中的代码生成规范节选](https://create.xyz/share/d51a6165-642a-4f30-a614-2a1ddf91ab74)

---

### Google Firebase Studio

- **App Prototyping agent（原型代理）：** Google 文档明确当前 **生成与发布 Next.js Web 应用**（其他框架写为 planned）。  
- **一般代码工作台：** 仅就 **Web**：模板库覆盖 **React、Next.js、Vue、Angular、Svelte、Astro** 等；官方另列 Android/Flutter 等 **非浏览器** 模板，**不在本文逐项对应**。

**依据：**  
- [Get started with the App Prototyping agent（Next.js）](https://firebase.google.com/docs/studio/get-started-ai)  
- [Firebase Studio templates（多框架列表）](https://firebase.google.com/docs/studio/get-started-template)

---

### 腾讯云开发 CloudBase · AI Toolkit / MCP

- **Web：** 文档写明支持 **React、Vue、Next.js** 等与云开发结合的 Web 集成；控制台/社区文章常以 **React 组件 + 云函数** 演示 AI 生成全栈。

**依据：**  
- [CloudBase AI 原生开发 / MCP（应用集成：React、Vue、Next.js）](https://docs.cloudbase.net/ai/cloudbase-ai-toolkit)  
- [开发指南 · Web 应用（React/Vue 等）](https://docs.cloudbase.net/ai/cloudbase-ai-toolkit/development)

---

### 百度「秒哒」

- **本文范围：** 仅在讨论 **浏览器可访问的营销页 / H5 / 网站类交付**；其宣传中的小程序等宿主 **本条不逐项建档**。  
- **定位：** 多轮第三方介绍强调 **对话 + GUI 拖拽**、多智能体、托管在百度智能云。  
- **源码可见性：** 常见表述为 **不提供或弱化「源码下载」**，偏业务闭环。  
- **Web 技术栈：** 公开可查的统一前端框架白皮书 **未见**；**勿**套用海外 MeDo 的 React+Vite 口述结论。

**依据（第三方概述，非唯一信源）：**  
- [秒哒介绍页（miaoda.cn 聚合说明）](https://www.2090ai.com/miaoda)  

---

## 扩展：同属一类但「栈取决于你的仓库」（Web 建站仍成立）

以下工具 **不产生平台统一的默认 SPA 写法**：你在仓库里已是 Next / Vite SPA / Astro，Agent 就跟着写——**本篇仍收录**，因其常用于 **迭代网站代码库**。

- **GitHub Spark、Copilot Workspace、Cursor、Windsurf 等：** IDE / Agent + **你的 Web 仓库**。  
- **Vercel 部署：** 与产物是 **站点**相关，但与「建站工具自身用何语言写」区分开。

---

## 使用建议

1. **以生成代码为准：** `package.json`、`vite.config.*`、`next.config.*` 才是真实现状。  
2. **Bolt / Replit 等「环境型」工具：** 在首条提示里 **写清单式技术选型**（如「Next.js 14 App Router + TS + Tailwind + shadcn」），可减少模型随意混搭。  
3. **需要 SSR/SEO：** 优先考虑 **Next.js** 路径（与 v0、Vercel、Firebase Studio 原型代理等对齐）；偏 SPA、管理后台则以 **React + Vite** 更常见。  
4. **国产托管型（如秒哒）：** 若目标是 **可下载源码、自有域名部署的站点**，请先确认是否 **支持导出完整 Web 工程**；许多资料强调「成品应用/H5链接」而非 **GitHub 式目录交付**。  
5. **黑盒或未披露栈：** 表格中标注「未公开」的条目，不要用海外同类产品的惯例栈 **类推**。


## 参考文献（URL，节选）

| 主题 | 链接 |
|------|------|
| Lovable 技术栈 FAQ | https://lovable.dev/faq/capabilities/tech-stack/lovable-tech-stack |
| v0 全栈说明 | https://v0.dev/docs/full-stack-apps |
| Replit Agent 任意框架 | https://blog.replit.com/agent-on-any-framework |
| Bolt.new README | https://github.com/stackblitz/bolt.new/blob/main/README.md |
| MeDo 手记（栈描述） | https://dev.to/vineetnegi0101/i-built-a-60-second-reflection-app-that-paints-you-a-watercolor-keepsake-day-2-of-the-50k-medo-5065 |
| Base44 前端栈 | https://docs.base44.com/developers/app-code/overview/introduction |
| Trickle：React + Tailwind 表述 | https://trickle.so/blog/why-vibe-coding-works-a-guide-for-developers |
| Atoms 应用构建用例 | https://atoms.dev/usecases/app-and-website-builder |
| Tempo（YC）：Vite & Tailwind | https://www.ycombinator.com/companies/tempo-2 |
| Tempo：Next.js + Supabase 文档 | https://tempolabsinc.mintlify.app/Next.jsSupabasePolar |
| Create.xyz：生成规范节选 | https://create.xyz/share/d51a6165-642a-4f30-a614-2a1ddf91ab74 |
| Firebase Studio：App Prototyping / Next.js | https://firebase.google.com/docs/studio/get-started-ai |
| Firebase Studio：模板清单 | https://firebase.google.com/docs/studio/get-started-template |
| 腾讯云 CloudBase AI / MCP | https://docs.cloudbase.net/ai/cloudbase-ai-toolkit |
| CloudBase AI 开发指南 | https://docs.cloudbase.net/ai/cloudbase-ai-toolkit/development |
| 「灵光闪应用」报道（表格 D · 范围外参考） | https://www.163.com/dy/article/KQV7RV41051180F7.html |
