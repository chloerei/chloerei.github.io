---
layout: post
title: Atom 编辑器
---

[Atom](https://atom.io/) 是 Github 资助开发的新一代编辑器，它目标是要兼具 Sublime Text 和 Textmate 的便捷性还有 Vim 和 Emacs 的扩展性，号称“A hackable text editor for the 21st Century”。

最近 Atom 发布了官方的 deb 安装包，我终于可以用上这个编辑器。经过一天的试用，我认为 Hackable 的 21 世纪编辑器是名符其实的，并且可以预见 Atom 会成为未来一款很重要的编辑器。

## 为什么现在的编辑器不够好

过去五年我一直使用 Vim 作为主要的编辑器。Vim 和 Emacs 是两个被神化的编辑器，熟悉了 Vim 的编辑模式后会产生很大的依赖性。使用 Vim 时间太久，会产生 Vim 实现不了/不好的功能就是不需要的功能的想法。随着 Sublime Text 等编辑器的兴起，我开始感觉 Vim 有不足的地方：

1. 全字符界面，无法利用图形元素。
2. 没有标准的插件管理器。
3. 写插件门槛高，需要学习一门全新的语言（vimscript）

Vi 诞生自命令行时代，那时候显示器一行只能显示几十个字符，键盘上还没有方向键，vi 在当时是非常优秀的设计。但现在程序员的工作环境已经有了很大进步，有必要重新设计一款编辑器。

那么为什么不选择现在热门的 Sublime Text？我觉得它也有不好的地方：

1. 不开源，我担心它的开发效率，事实上它也更新得很慢。
2. 不免费，Linus 说过：“Software is like sex: it's better when it's free.”

综合之前说的，我理想中的编辑器是这样的：

1. 充分利用图形界面。
2. 可扩展，有插件管理器。
3. 开源免费，并且由商业公司资助。
4. 跨平台。

Atom 就正好满足了我所有要求，并且它基于 nodejs + chromium 开发，这意味我的 Web 开发经验也可以用于编辑器定制上。

## Atom 的体验

Atom 的界面很像 Sublime Text，默认提供了 文件目录树、Ctrl-p 模糊文件查找、Snippets 代码片段等功能，开箱即用。

![Atom](/images/posts/2014-10-15-atom-editor/atom.png)

我觉得很贴心的一个功能是 Snippets 列表，我经常发生定义了 Snippets 却忘了关键词的情况。

![Snippets](/images/posts/2014-10-15-atom-editor/snippets.png)

设置界面很简洁，分为设置/快捷键/包/主题/包设置五个部分，每个包（扩展）都是有设置界面的。可以看到很多 Atom 默认提供的功能都是由包实现的，模块化做得很好，不需要的功能可以自己去掉。

![Settings](/images/posts/2014-10-15-atom-editor/settings.png)

安装包可以在编辑器内完成搜索-安装-使用，即时生效不需要重启。

![Packages](/images/posts/2014-10-15-atom-editor/packages.png)

预装了一个 Markdown Preview 包，编码写作都可以用同一个编辑器。

![Packages](/images/posts/2014-10-15-atom-editor/markdown-preview.png)

至于代码高亮等基本功能我就不说了，总的来说，我对 Atom 的表现很满意。目前唯一遇到的大问题是 soft wrap 还不支持中文 [#1783](https://github.com/atom/atom/issues/1783)，我暂时用 [japanese-wrap](https://atom.io/packages/japanese-wrap)这个包解决。至于有人提到的响应速度问题，我完全没感受到（i5 + 8G 内存）。

## 前景

Atom 自 [Beta 发布](http://blog.atom.io/2014/02/26/introducing-atom.html)以来只不过 230天，我眼睁睁的看着一个未来的编辑器成型，现在 Atom 正朝着 1.0 里程碑迈进。

当然，它肯定还有很多问题，但技术问题最终都可以解决。关键的是 Atom 设立了一个正确的目标，有大量优秀的 Hacker 参与开发，并且由 Github 资助，可想而知它一定潜力无限。将来的开发者可以从刚开始学习的时候就使用 Atom 这样易用可扩展的编辑器，并且一直使用到工作环境。

如果你是个工具控，现在是时候入手了。
