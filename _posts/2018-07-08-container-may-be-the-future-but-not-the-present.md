---
layout: post
title: 容器也许是未来，但不是当下
---

自从 Docker 发布以来，我已经看到很多次“容器是未来”。随着了解越来越深入，我的态度也从怀疑转到肯定。容器确实有很多优点，包括但不限于：

- 容器可以让运行环境用文件的形式固化，并提交到代码库。
- 容器可以确保开发环境和生产环境一致，而不是到部署的时候重新搭建一套类似的环境。
- 容器可以秒级扩展，而虚拟机创建通常需要几分钟。

有这个几个优势，即使不考虑追踪、日志、服务治理等平台化的功能，我也相信容器会是未来。不过，尽管我已经在开发环境使用 Docker 两年多了，却一直没有把部署环境切换到 Docker，原因是部署平台不完善。

可能有人会提起 kubernetes。kubernetes 已经在编排领域胜出，各大云服务商都已经推出或者预览托管 kubernetes 集群功能。看来 kubernetes 已经为生产环境准备好了？

![](/images/posts/2018-07-08-container-may-be-the-future-but-not-the-present/flower.png)

最近我尝试将一个小应用部署到 Google kubernetes Engine 上，但过程只能用痛苦来形容。概括来说需要做这些事情：

1. 创建 kubernetes 集群，选择需要的虚拟机配置和数量。
2. 学习 CloudSQL 的 Proxy 验证。（Google Cloud 特有）
3. 编写 Deployment，Service 和 Ingress 配置。（需要学习一大堆 kubernetes 知识）
4. 将 Docker image push 到合适的仓库。
5. 执行 `kubectl apply`。

这个小项目的配置开源在 https://github.com/getcampo/campo-gcloud ，但不指望没有 kubernetes 基础的人能看懂。还有一些想做但还没做的事情：

1. 自动领取 SSL 证书（Let's Encrypt）。
2. CI/CD 集成。

但我已经放弃再继续摆弄下去，因为发现：1）kubernetes **完全没有减少部署的工作量**，说不定更多了。2）**太多配置和操作是由人来完成**，出错几率加大。我对 kubernetes 的了解还不够深，不确定遇到问题的时候是否能快速解决。曾经就因为一个配置写了布尔值而 kubernetes 只认字符串而报错，让我调试了一小时。

kubernetes 是不是太难了？每个技术人员都不会轻易开口说这句话，因为这会显得自己不够聪明。不过有篇文章说明这不是我一个人这么想：[Will Kubernetes Collapse Under the Weight of Its Complexity?](https://www.influxdata.com/blog/will-kubernetes-collapse-under-the-weight-of-its-complexity/)。

> However, I felt there was an underlying problem with the whole spectacle: everyone I talked to was either an operator or an SRE. Where were all the application developers? Aren’t those the people that all this complex infrastructure is supposed to serve? Is this community really connected with the needs of its users? And it made me wonder: is Kubernetes too complex? Will it end up collapsing under the weight of its own complexity? Will it fade away as OpenStack has seemed to since 2014?

看了这个 Cloud Native 大会的景观图，我倒觉得前端的混乱状况有点可爱了。到底需要学习多少工具，添加多少抽象层才能把容器用起来？

![](/images/posts/2018-07-08-container-may-be-the-future-but-not-the-present/cloud-native-landscape.png)

不过让人欣慰的是，至少有一个厂商作出了开发者需要的产品：Heroku。

Heroku 是 2007 年推出的云平台服务，可能很多人对 Heroku 的印象还停留在它的 buildpack 机制上：通过 Git 把代码 push 到 heroku repo，heroku 执行 buildpack 把应用构建部署到它的平台上。在 Docker 兴起后，一度有人认为 Heroku 要完了，因为围绕 Docker 完全有可能搭建一套开源的 Heroku 平台。相比之下，buildpack 只是 Heroku 自家的技术，人们不想被绑定在一个平台上。

如果近几年你没有使用 Heroku，那么你可能需要更新认识，因为 Heroku 已经完全拥抱 Docker。在 2015 年，Heroku 已经实现 [Docker Deploy](https://blog.heroku.com/introducing_heroku_docker_release_build_deploy_heroku_apps_with_docker)，而不需要 buildpack。到了 2017 年底，Heroku 又推出了 [heroku.yml build manifest](https://devcenter.heroku.com/changelog-items/1332)。

heroku.yml 是啥？看例子最直观：

```yaml
build:
  docker:
    web: Dockerfile.web
    worker: Dockerfile.worker
release:
  image: web
  command:
    - bin/rails db:migrate
```

这几行配置已经实现了前面说的[一大坨 kubernetes 的配置](https://github.com/getcampo/campo-gcloud)。`heroku.yml` 配置很简洁，没什么学习成本。开发人员不用学习 Deployment、Service、Ingress 还有其它一大堆概念，只要告诉 Heroku 需要什么进程，该进程的镜像通过什么 Dockerfile 构建，Heroku 就自动把工作做好。另外只要绑定 GitHub，就可以很容易地把 CI/CD 跑起来。Heroku 背后完成了很多工作，留给开发人员简洁的界面，这才是平台需要做的事情。

当然，Heroku 也不完美：

- 平台绑定的问题。（其实哪个云平台没有？）
- 只对企业客户开放美欧以外的区域，没有中国。

所以，目前我也只能把业余项目放到 Heroku 上，并且羡慕用 Heroku 就能满足需求的地区……

在容器混战时代，Heroku 像一股清流，在所有人找不清方向的时候给出了接近完美的答案。希望更多云平台商能向 Heroku 学习，让开发者不再受部署所困，放更多精力放在开发上。容器也许是未来，希望这个未来能早点到来。
