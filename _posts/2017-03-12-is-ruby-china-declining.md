---
layout: post
title: Ruby China 正在衰退吗？
---

Ruby China 是一个非营利的开源社区，不知不觉已经成立了 6 年。作为管理员之一，我一直不觉得是由管理员创建了这个社区，而是 Ruby 爱好者自发聚集组成了社区，我在里面只是担任了清洁工一类的角色。

我最近经常被问到的一个问题是：

> Ruby China 活跃度是不是越来越低了？

主观上我也觉得 Ruby China 的热度有所降低，由于此前没有具体的数字，所以我做了一些调查。

![](/images/posts/2017-03-12-is-ruby-china-declining/ga.png)

访问量总体还是呈上升趋势，因为论坛上积累了很多内容，形成了长尾效应。

![](/images/posts/2017-03-12-is-ruby-china-declining/users.png)

注册人数平稳，除了某个月份有点异常，先忽略。不过下面两个图看出了问题：

![](/images/posts/2017-03-12-is-ruby-china-declining/topics.png)

![](/images/posts/2017-03-12-is-ruby-china-declining/replies.png)

糟糕，话题数和回复数从 2013 年开始就一直在下降。从这个数据上看，**Ruby China 确实是活跃度越来越低**。但……我并不认为这是个大问题。一直以来活跃度都不是管理员们关注的指标，相应的我们关心社区里的人实际在交流什么，有什么建设性的想法，哪里要举办线下聚会，哪个公司使用了 Ruby 正在招人。一些会让社区很热闹，但实质上没有营养的帖子会被毫不犹豫的移到 NoPoint 节点。所以 Ruby China 一直在技术圈有良好的口碑，并且每年举办 RubyConf。

不过我想大家真正关心的是：Ruby 是不是正在衰退，毕竟这关系到新手能不能找到工作、老手以后会不会失业。我觉得需要认识到两点：

**Ruby 确实已经不热门了。**Ruby 在国外 07 ～ 09 年就达到了宣传的巅峰，我在 09 年刚接触 Ruby 的时候就看到国外对 Ruby 狂热的反思，有人花了两年用 Rails 重写网站失败，[然后又用两个月回到 PHP](https://sivers.org/rails2php)。支持我学下去的原因是对我来说 Ruby 比 Java/PHP/Python 好学（没错，我都学过，没学会），用 Rails 我第一次做出了有 CRUD 的完整网站。

标志性的事件是在 11 年 [Twitter 从 Ruby 向 Scala 迁移](http://www.infoq.com/cn/news/2012/11/twitter-ruby-to-java)，Ruby 的狂热破灭了，Ruby 被烙上了性能不佳、无法扩展的印记，每个 Ruby 项目似乎迟早要被替换。不过，也有一些成熟的公司一直在用 Ruby：Basecamp，GitHub，Shopify，Airbnb，Twitch，SoundCloud……

近年来，新语言新框架层出不穷，Go、Node.js、Elixir，很多新技术都在冲击 Ruby 的强项 Web 端。新技术最常见的推销方法就是写一个 Hello World 的性能测试跟 Rails 比较。从企业角度使用 Rails 不再代表团队的有多先进，从新手角度学习 Ruby 不再代表将来有很多工作机会。

**Ruby 正在走向成熟。**[技术热门度曲线](http://www.ruanyifeng.com/blog/2017/03/gartner-hype-cycle.html)模型认为，一门技术的发展要经历五个阶段：启动期-泡沫期-低谷期-爬升期-高原期。据 [State.of.dev](https://stateofdev.com/t/programming-language) 的分析，Ruby 正处于低谷期：

![](/images/posts/2017-03-12-is-ruby-china-declining/programming-language-state-of-dev.svg)

StackOverflow 和 Discourse 的创始人 Jeff Atwood 写道：

> Ruby 不再酷了，追酷的人几年前都到了 Scala 或者 Node.js。我们的项目也不酷，只是一坨老旧的 Ruby 代码。从个人角度，我很庆幸 Ruby 已经成熟到不需要把自己打扮成最酷的孩子。这意味着我们这些只想把事情搞定的人可以专注做正经事，不用再去找下一个闪光点。
> ——[Why Ruby](https://blog.codinghorror.com/why-ruby/)

不止一个人跟我说过，在 Ruby China 上好像没什么好讲了，该踩的坑已经踩过，该吐的槽都吐过。但是，他们都在工作中使用 Ruby，用 Ruby 开发商业项目不再被怀疑是个很大风险。到[招聘板块](https://ruby-china.org/jobs)看看，Ruby 已经走入各行各业，也许每天使用的服务后面就有 Ruby 的应用。

当然，Ruby China 作为最大的 Ruby 中文社区，有义务跟上 Ruby 的发展。17 年至今已经做了以下事情：

- [上线打赏功能](https://ruby-china.org/topics/32376)。
- [上线头条功能](https://ruby-china.org/posts)。
- [赞助 Rails Guides 翻译](https://ruby-china.org/topics/32272)。
- 设计新的 LOGO 和 UI（进行中）。

这些改进都是为了方便让新手能找到学习资料，老手能分享行业经验，企业能找到适合的人才。我们利用业余时间维护 Ruby China，只为了让社区发展更好，毕竟我们已从开源获益良多。

最后，我贴一下我面试现在这家公司时回答的最后一个问题：

> “你觉得 Ruby 好在哪里？”
>
> “我觉得 Ruby 好的地方，是它被设计为让程序员快乐。Ruby 有很多便利的语法，但语法很容易被别的语言借鉴，唯有它的理念独树一帜。Ruby 一直让我觉得编程很快乐。”
