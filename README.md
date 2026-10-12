# xzwang's life

这是一个 Hugo 静态个人博客与课程作品集。它不需要服务器、数据库或付费托管；发布后访问地址为：

`https://xzzwang26.github.io`

## 首次发布

1. 在 GitHub 创建一个 **公开** 仓库，名称必须是 `xzzwang26.github.io`。
2. 将本目录中的全部文件提交并推送到该仓库的 `main` 分支。
3. 打开仓库的 **Settings > Pages**，在 **Build and deployment** 下选择 **GitHub Actions**。
4. 推送后前往 **Actions**，等待 `Deploy Hugo site to Pages` 工作流完成。
5. 打开 `https://xzzwang26.github.io`。首次部署可能需要一两分钟生效。

之后每次向 `main` 推送，网站都会自动重新构建并发布。

## 修改站点名称

编辑 `hugo.toml` 中的 `title`：

```toml
title = "xzwang's life"
```

改标题不会影响 GitHub Pages 地址。

## 新增作品

在 `content/projects/` 下新建一个 Markdown 文件，例如 `course-poster.md`：

```md
---
title: "Course Poster"
date: 2026-10-12
summary: "A short description of this project."
tags: ["coursework", "design"]
cover: "images/course-poster.jpg"
coverAlt: "A concise description of what the project cover shows"
externalURL: "https://example.com"
---

Write the project story here.
```

把封面图放进 `static/images/course-poster.jpg`。`coverAlt` 要描述图片实际内容，方便使用屏幕阅读器的人理解；没有封面时，删除 `cover` 与 `coverAlt` 两行即可。

## 新增笔记

在 `content/notes/` 下新建一个 Markdown 文件，例如 `first-note.md`：

```md
---
title: "First Note"
date: 2026-10-12
summary: "A short introduction to this note."
tags: ["reflection"]
---

Write the note here.
```

项目会出现在 **Projects**，笔记会出现在 **Notes**。两个列表在没有内容时会显示空状态，因此可以先发布空架构，再逐步添加课程作品。
