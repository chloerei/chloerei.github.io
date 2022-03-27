---
layout: post
title: 为你的所有敏感账户开启两步验证
---

昨天 Hack News 上顶上来一篇帖子：[Github seems to be experiencing security issues](https://news.ycombinator.com/item?id=6759786)，里面有人汇报自己的 Github 安全记录里面出现很多失败的登陆，似乎有人试图暴力破解密码。

同一天稍晚时候，Github 官方博客就发布文章：[Weak passwords brute forced](https://github.com/blog/1698-weak-passwords-brute-forced)，确认有用户因为使用弱密码而被攻破。

今天 V2EX 上也有人发帖说自己的帐号被攻破了：[我github被攻破了](http://www.v2ex.com/t/89900)。

如果 Github 帐号被攻破，我可以想象到做以下坏事：

- 盗取私有源的源码
- 如果帐号拥有者是流行库的作者，可以给流行库插入后门代码
- 登陆其他关联 Github 帐号的服务

## 密码是不安全的

![](/images/posts/2013-11-20-enable-two-factor-authentication-for-all-your-sensitive-accounts/why-need-img-1.png)

我不是专门研究网络安全的，不过我越来越觉得，密码是不安全的，通常风险会这样产生：

1. 不同网站的帐号用了同一个密码
2. 某个网站的安全系数不高，用户数据被泄露
3. 泄露数据被破解，导致其他网站用同样密码的帐号也被攻破，其中可能有敏感帐号
4. 密码被破解后可能一段时间内不会被发现，直到骇客某一天发现了你某个帐号的价值，才引爆这个炸弹

我也曾犯过错误，导致用户数据泄露。搭建一个网站时，要考虑的问题太多了，任何一个环节出问题都有可能被攻破，起步阶段又没有条件请专人来负责。所以现在我看到安全级别不像很高的网站时，要不就不注册，要不就当作肯定会被泄露。

之所以我们不同网站都用了同一个密码，是因为记不住那么多密码，不过有一些软件可以解决这些问题：

- [1Password](https://agilebits.com/onepassword)
- [KeePass](http://keepass.info/)
- [Lastpass](https://lastpass.com/)

这些软件可以为你针对不同网站生成不同的随机密码，在下次登陆的时候自动填写表单，你只需要记这个软件的管理密码。

不过我还没有用其中一个，因为觉得用一个密码管理其他密码，颇有鸡蛋摆在一个篮子里的感觉（还是比所有鸡蛋都不放篮子好多了）。如果你对这类软件有心得欢迎留言交流。

## 两步认证

![](/images/posts/2013-11-20-enable-two-factor-authentication-for-all-your-sensitive-accounts/how-works-img-1.png)

现在国外注重账户安全的服务都提供了两步认证了，例如 Google、Dropbox、Linode、Amazon，如果你经常使用这些服务，那么不难想象到这些账户泄露会造成什么危害。

那么什么是两步认证呢？两步认证就是在每次登陆时候填一个手机短信收取或者手机应用生成的验证码。当然接收验证码的手机号或者应用是需要绑定的，这样只有拿到这部手机并且知道你帐号密码的人才能登陆帐号。

支持两步认证的网站都已经写了一份帮助文档了，所以我不重复劳动：

- [Google](http://www.google.com/intl/zh-CN/landing/2step/)
- [Dropbox](https://www.dropbox.com/help/363/zh_CN)
- [Linode](https://library.linode.com/linode-manager-security#sph_two-factor-authentication)
- [Amazon](http://aws.amazon.com/cn/mfa/)

虽然他们文案不同，但流程是相似的：

1. 选择开启两步认证
2. 选择用短信还是用应用
3. 填写接收到的验证码进行绑定
4. 填写备用手机号

## 两步验证麻烦吗？

![](/images/posts/2013-11-20-enable-two-factor-authentication-for-all-your-sensitive-accounts/how-works-img-2.png)

Google 其实很早就提供两步验证了，但是我一直没有开启，一来觉得自己的数据敏感性还不高，二来觉得两步验证登陆的时候很麻烦。

不过我今天操作下来后，感觉也并不麻烦，有几个理由：

- 只有重新登陆的时候需要两步验证，记住登陆功能还是能用的
- Google 可以登陆后允许当前电脑不需要两步验证（其他电脑需要）
- 如果不喜欢短信，可以绑定 [Google 身份验证器](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2)，它根据密钥和时间戳生成验证码，无需通信网络和互联网

所以开启两步验证后，并不影响日常使用，而帐号要安全了许多。安全起见，这些敏感账户还是要设置不同的强密码。

你的帐号可能远比你想象的有价值，强烈建议为你的所有敏感账户开启两步验证。

_\* 插图来自 [Google 两步验证](http://www.google.com/landing/2step/)_
