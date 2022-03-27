---
layout: post
title: 用 Docker Compose 搭建 Rails 开发环境
---

Docker 是目前最热门的容器格式，Docker Compose 是用于管理包含多个 Docker 容器的应用的工具，借助 Docker 和 Docker Compose，我们可以轻松搭建可复现的开发环境。

这篇教程展示如何从零开始用 Docker Compose 搭建 Rails/PostgreSQL 开发环境。

> 本文主要参考了 [Quickstart: Compose and Rails](https://docs.docker.com/compose/rails/)。但原文有[一点问题](https://github.com/docker/docker.github.io/issues/3024)，于是我加上自己的见解写成这篇博客。

## 安装 Docker

首先，需要在自己的开发机上安装 Docker，你可以在 https://www.docker.com/ 找到适合自己操作系统的 Docker 安装方式。

安装完毕后，可以在命令行中使用 `docker` 命令：

```bash
$ docker --version
Docker version 17.03.1-ce, build c6d412e
```

## 创建项目

创建项目目录：

```bash
$ mkdir myapp
$ cd myapp
```

接着，创建一个 `Gemfile` 文件，包含以下内容：

```ruby
source 'https://rubygems.org'

gem 'rails', '5.1.0.rc2'
```

然后，创建一个空的 `Gemfile.lock` 文件：

```bash
$ touch Gemfile.lock
```

之所以这么做，是因为不希望在主机环境安装 Ruby 和其它依赖，而是都放到镜像中。这两个文件用于在镜像中安装 Rails。

接着，创建一个 `Dockerfile` 文件，该文件用于定义如何构建 Rails 镜像：

```Dockerfile
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y curl apt-transport-https && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  ruby \
  ruby-dev \
  tzdata \
  yarn \
  zlib1g-dev

WORKDIR /app

RUN gem install bundler
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app
```

这个 `Dockerfile` 基于 Ubuntu 16.04，安装了创建 Rails 项目所需要的基础包，并将项目目录设定在 `/app`。你可以阅读 https://docs.docker.com/ 学习怎么定制 `Dockerfile`。

然后，创建一个 `docker-compose.yml` 文件，该文件用于定义 `docker-compose` 如何启动应用：

```yaml
version: '2'
services:
  web:
    build: .
    command: bundle exec rails s -p 3000 -b 0.0.0.0
    volumes:
      - .:/app
    ports:
      - 3000:3000
    depends_on:
      - db
  db:
    image: postgres
```

在这个文件里，我们定义了两个服务。`web` 服务用于运行 Rails，镜像将根据当前目录的 `Dockerfile` 构建；`db` 服务用于运行 PostgreSQL 进程，镜像使用 Docker 官方提供的 `postgres`。你可以在 https://docs.docker.com/compose/compose-file/ 找到其它配置的定义。

接下来，执行以下命令：

```bash
$ docker-compose run web rails new . --force --database=postgresql
```

该命令会在当前目录创建 Rails 项目：

```bash
$ ls -l
total 72
-rw-r--r--   1 rei  staff   522  4 25 22:59 Dockerfile
-rw-r--r--   1 rei  staff  1989  4 25 23:02 Gemfile
-rw-r--r--   1 rei  staff  4847  4 25 23:03 Gemfile.lock
-rw-r--r--   1 rei  staff   374  4 25 23:02 README.md
-rw-r--r--   1 rei  staff   227  4 25 23:02 Rakefile
drwxr-xr-x  10 rei  staff   340  4 25 23:02 app
drwxr-xr-x   9 rei  staff   306  4 25 23:03 bin
drwxr-xr-x  14 rei  staff   476  4 25 23:02 config
-rw-r--r--   1 rei  staff   130  4 25 23:02 config.ru
drwxr-xr-x   3 rei  staff   102  4 25 23:02 db
-rw-r--r--   1 rei  staff   206  4 25 22:59 docker-compose.yml
drwxr-xr-x   4 rei  staff   136  4 25 23:02 lib
drwxr-xr-x   3 rei  staff   102  4 25 23:02 log
-rw-r--r--   1 rei  staff    61  4 25 23:02 package.json
drwxr-xr-x   9 rei  staff   306  4 25 23:02 public
drwxr-xr-x  11 rei  staff   374  4 25 23:02 test
drwxr-xr-x   4 rei  staff   136  4 25 23:02 tmp
drwxr-xr-x   3 rei  staff   102  4 25 23:02 vendor
```

接着，重建 Docker 镜像：

```bash
$ docker-compose build
```

每当修改了 Dockerfile，你都需要重建镜像。如果修改了 Gemfile，还需要先在容器内运行 `bundle`，然后重建镜像：

```bash
$ docker-compose run web bundle
$ docker-compose build
```

## 连接数据库

现在我们已经可以让 Rails 跑起来，但还需要修改一些配置让 Rails 连上数据库。默认情况下，Rails 的 `development` 和 `test` 环境会连接 `localhost` 主机上的数据库，根据之前的 `docker-compose.yml` 配置，我们需要将数据库的主机名改为 `db`。另外，还需要修改 `username` 以适配 postgres 镜像的默认配置。修改后的 `database.yml` 配置如下：

```yaml
development:
  <<: *default
  database: app_development
  host: db
  username: postgres

test:
  <<: *default
  database: app_test
  host: db
  username: postgres
```

现在可以启动 Rails 进程了：

```bash
$ docker-compose up
```

如果一切正常，你会看到一些 postgres 的日志，然后是 Rails 启动日志：

```
web_1  | => Booting Puma
web_1  | => Rails 5.1.0.rc2 application starting in development on http://0.0.0.0:3000
web_1  | => Run `rails server -h` for more startup options
web_1  | Puma starting in single mode...
web_1  | * Version 3.8.2 (ruby 2.3.1-p112), codename: Sassy Salamander
web_1  | * Min threads: 5, max threads: 5
web_1  | * Environment: development
web_1  | * Listening on tcp://0.0.0.0:3000
web_1  | Use Ctrl-C to stop
```

如果你需要运行数据库迁移，可以打开另一个终端运行：

```bash
$ docker-compose run web rails db:create
$ docker-compose run web rails db:migrate
```

> TIP: 以后运行 `rails` 命令，都需要在前面加上 `docker-compose run web`。

用浏览器访问 http://localhost:3000 ，你会看到 Rails 的欢迎信息：

![](/images/posts/2017-04-24-docker-compose-for-rails-development/rails.jpg)

将 `Dockerfile` `docker-compose.yml` 与项目文件一并提交到版本控制里，这样新开发者参与项目的时候就可以用 `docker-compose up` 一键启动开发环境。
