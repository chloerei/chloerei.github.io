---
layout: post
title: The Twelve-Factor App
---

做了几年 Web 开发，我不得不说句：部署一个应用很麻烦。

从零开始部署一个 Rails App，首先要开启一个服务器，在上面安装所需的系统应用例如数据库、缓存，然后用 git 把代码 clone 到服务器，编辑一些部署参数，最后再用 cap 执行 deploy 过程。这个过程烦琐、步骤多，即使写成脚本，需要人工处理的地方还是不少。如果需要迁移服务器，或者开一个预发布环境，这个流程就要重走一遍。我一直觉得这个过程不对劲，应该有更好的处理方法，但是我不知道怎么改进。

最近我仔细研究 Heroku 的部署流程，Heroku 最吸引我的是它完全不需要管理服务器的细节。需要创建应用？像 git 那样敲一下命令。需要连接数据库？通过环境变量设置数据库的地址和端口信息。需要增加节点？用命令行工具或者网页面板改一下参数就行了。

当然并不是说完全不需要学习服务器知识了，不掌握服务器的基础知识也无法有效利用 Heroku，遇到问题还不会处理。但是对于掌握了基本知识，又不想花太多精力管理基础设施的开发者来说，Heroku 真的很省事。

我在刚学习 Rails 的时候就知道 Heroku 了，一直没有使用是因为担忧 PaaS 会局限应用的部署方式。但最近我看了 [The Twelve-Factor App](http://12factor.net/) —— Heroku 创始人之一兼 CTO Adam Wiggins 所写的应用部署方案，我开始抛弃之前的担忧，Heroku 式的部署其实更灵活和可靠。

我简要描述一下这套方案提到的 12 个要素，完整内容请看原文。

1. 用版本管理库管理代码，例如用 git。
2. 声明并且隔离依赖，例如用 Bundler。
3. 把应用设置保存在环境变量中。
4. 把后端服务当作附加资源。
5. 明确区分 build 和 run 过程。
6. 应用运行为无状态的单个或多个进程。
7. 通过端口对外提供服务。
8. 通过进程模型水平扩展。
9. 能快速启动和安全关闭，高稳健性。
10. 开发和生产环境尽可能保持一致。
11. 日志通过标准流输出。
12. 管理任务作为一次性流程执行。

如果一个应用符合这 12 个要素，那么它就很容易在不同的部署平台间切换，也能很容易进行水平扩展。

举个例子，如果将用户文件储存在本地文件系统，那么在水平扩展——增加服务器的时候就会出现麻烦，这时候要不把文件储存独立成一个服务，要不使用第三方的储存服务。这就是把后端服务当作附加资源，并且资源是通过 Web 的方式提供服务的。

这跟最近火热的容器 Docker 的设计理念很相似，都是把应用独立在一个容器中，相互间通过 Web 提供服务。而 Heroku 是在 2007 年创建的，可见其创始人的理念很先进。也许一些商业公司内部很早开始这么做，但是 Heroku 是较早做成一个对外平台的。

经过这轮学习，我很认同 Heroku 的理念，并且他们提供的管理工具实在太方便了，我打算未来将应用部署到 Heroku。现在，我已经开始按照 The Twelve-Factor App 重构应用了。
