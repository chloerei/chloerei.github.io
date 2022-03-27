---
layout: post
title: 你不需要这些 Gems
---

每个开发者都应该有自己的判断和品味，所以我通常只分享我用什么，以及某个技术有什么好处。我不喜欢评价别人用什么，搞技术就是要多折腾，有时不折腾不会了解自己需要什么。

Ruby Web 开发有很多 Gems 可以用，这本来是增加生产力的工具，不过最近经常见到有人遇到的问题来自于他们用了某个不必要的东西，这本来是可以避免的。我把它们整理如下，判断留给开发者自己。

## Devise

[Devise](https://github.com/plataformatec/devise) 是 Rails 上最出名的用户认证 Gems，Github Star 数近一万（写作时是 9589），但在我看来，它机制太过复杂，我从来没读懂过。每次要对它的流程进行定制，都要搜索它的文档，查找某个特定的 method 然后覆盖，都不明白原理是什么。

如果你曾经看过它的源码，会发现很多 `resource` `scope` 这样的命名，这是因为 devise 支持认证多个 Model，对大多数应用这个特性是不必要的。为了支持这层抽象，devise 又写了更多代码来包装，你会在这些跟自己应用无关的代码里迷失。

那么我们该用什么 Gem？不，用户认证不需要 Gem，我们可以自己手写一个：

1. ActiceModel 里面已经有了 [SecurePassword](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html) Module，用来加密用户密码。
2. 阅读 [Authentication in Rails 3.1](http://railscasts.com/episodes/270-authentication-in-rails-3-1?view=asciicast)，很简单就可以用 Rails 自带的 Model 和 Session 实现用户认证。

用户模型是大多数应用的核心，肯定会有需要定制化的时候，不要到了那个时候发现自己驾驭不了用户认证。

## Cancan

[Cancan](https://github.com/ryanb/cancan) 只做了一件事：怂恿我们把权限逻辑都挤到一块，让代码变得一团糟。

Rails 本身就有很适合做权限机制的方法：`before_filter`，例子：

```ruby
before_filter :require_resource_owner, :only => [:destroy] # :except is better

def destroy
  # dangerous action
end

private

def require_resource_owner
  unless is_resource_owner?
    # bad request
  end
end

def is_resource_owner?
  @resource.owner == current_user
end
```

在 filter method 里面，我们可以拿到权限认证需要的一切条件：用户对象、相关资源、session、cookies，验证码等等。把这个方法放到适当的控制器，就可以限定它的使用范围，是全局还是局部。

需要 Helper 也非常简单，在同一个控制器加上：

```ruby
helper_method :is_resource_owner?
```

当需要实现更复杂的权限判断时，重要的是自己的设计，Cancan 帮不上什么忙。

## Simple Form

[Simple Form](https://github.com/plataformatec/simple_form) 没 Simple 多少，来看它 README 里的例子：

```erb
<%= simple_form_for @user do |f| %>
  <%= f.input :username %>
  <%= f.input :password %>
  <%= f.button :submit %>
<% end %>
```

对比 Rails 原生的 Form Builder 就是少了行 `label` 代码。Simple Form 可以一次修改所有相同类型的表单，但实际中很多表单是不同的：注册表单、个人信息表单、发帖表单的外观和行为都各不相同。Simple Form 处理这些不同种类的表单时，代码量不降反增。

当我们想要修改表单的时候，最好的方法是修改 HTML 标签，而不是修改 Ruby 代码。不必要的抽象会增加维护成本。

## Rspec

[Rspec](http://rspec.info/) 跟 Test::Unit 之争基本有定论了：品味。但我还是很困惑为什么那么多人喜欢 Rspec。

不是什么时候都需要 DSL，我判断 DSL 好不好的准则是：它是否语义清晰，是否减少代码。来看例子：

```ruby
# Test::Unit
class FooTest < Test::Unit::TestCase
  def test_should_pass
    assert foo.bar?
  end
end
```

```ruby
# Rspec
describe Foo do
  it "should_pass" do
    expect{foo.bar?}.to be_true
  end
end
```

在我看来代码量是一样的，但是 Rspec 的 DSL 增加了很多词语。同样一条判断，Rspec 有三个词语 `expect` `to` `be_true`，而 Test::Unit 只有一个 `assert`。我总是困惑为什么是 `.to be_true`，而不是 `to_be_true` 或者 `to_be true`。

`Test::Unit` 就是 Ruby，用 Ruby 的思维就能理解它的语法。这意味着不查文档，我也可以写一个新的 `assert` 方法：

```ruby
def assert_something(object)
  assert do_something(object)
  # More asserts
end
```

很多人之所以选择 Rspec 而不用 Test::Unit，是因为看到别人用 Rspec，甚至没用过 Test::Unit。还有一些方法论爱好者会说：“我们要 BDD，不要 TDD”，这是方法论，无关用什么工具。

## Cells

我不知道什么情况下有必要用到 [Cells](https://github.com/apotonick/cells) 这样的 Gem，类似的还有 [Draper](https://github.com/drapergem/draper)，都是在 View 层再加一个小的 VC 组合。

它文档上的例子就是出现在全局的个人购物车片段，如果是我会用局部模板实现：

```erb
<%= render :partial => 'share/cart', locals => { user => current_user } %>
```

实际上 current_user 是个全局 helper，可以不用写的，这里是为了突出 locals 的作用。然后写一个局部模板 `share/_cart.html.erb`：

```erb
<div id="cart">
  You have <%= user.items_in_cart.size %> items in your shopping cart.
</div>
```

完成了，不需要那么复杂。

## 总结

我谨慎使用这些增加抽象，但是对提高代码清晰度和减少代码量没帮助的 Gems。
