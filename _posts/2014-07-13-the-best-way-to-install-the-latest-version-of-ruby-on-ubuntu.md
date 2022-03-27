---
layout: post
title: Ubuntu 通过 PPA 安装 Ruby
---

最佳方法是通过 PPA 安装：

```
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt-get update
sudo apt-get install ruby2.2 ruby2.2-dev
ruby -v
```

PPA 的优点是可以用 apt 统一更新，不用处理 PATH 等问题。

如果你希望 gem 安装在用户目录，那么在 `~/.bashrc` 添加以下配置：

```bash
export GEM_HOME="$(ruby -rubygems -e 'puts Gem.user_dir')"
export PATH=$GEM_HOME/bin:$PATH
```

> Gem 有一个 `--user-install` 参数，但 Bundler 不会理会这个设置，而是读取 `GEM_HOME` 这个环境变量。

安装使用多版本的方法请阅读 Brightbox PPA 的说明：

https://www.brightbox.com/docs/ruby/ubuntu/
