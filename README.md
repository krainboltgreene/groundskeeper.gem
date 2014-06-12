groundskeeper
-------------

  - [![Version](https://badge.fury.io/rb/groundskeeper.png)](https://rubygems.org/gems/groundskeeper)
  - [![Climate](https://codeclimate.com/github/krainboltgreene/groundskeeper.gem.png)](https://codeclimate.com/github/krainboltgreene/groundskeeper.gem)
  - [![Build](http://img.shields.io/travis-ci/krainboltgreene/groundskeeper.gem.png)](https://travis-ci.org/krainboltgreene/groundskeeper.gem)
  - [![Dependencies](https://gemnasium.com/krainboltgreene/groundskeeper.gem.png)](https://gemnasium.com/krainboltgreene/groundskeeper.gem)
  - [![Gittip](http://img.shields.io/gittip/krainboltgreene.png)](https://www.gittip.com/krainboltgreene/)
  - [![License](http://img.shields.io/license/MIT.png?color=green)](http://opensource.org/licenses/MIT)

This gem helps you parse various parts of a request and determine the owner
of the request in a multi-tenant environment.


Using
=====

Simply add the middleware to your stack with the options required as explained below:

**Example: Rails**

``` ruby
# config/application.rb

#...

module Testapp
  class Application < Rails::Application


    # ...

    config.middleware.use(Groundskeeper::Middleware::Subdomain, model: "Company")
  end
end
```

Now during any request the 3rd-level subdomain (`www` in `www.example.com`) will be used to find the company.

The exect query is as follows:

``` ruby
model.find_by_slug(slug)
```

To change the query lookup simply provide Groundskeeper with the prefered query:


``` ruby
...use(Groundskeeper::Middleware::Subdomain, model: "Company", query: ->(model, name) {
  model.where(name: name).first
})
```

If you want to look at the 2nd-level subdomain (`example` in `www.example.com`) just tell Groundskeeper to do that:

``` ruby
...use(Groundskeeper::Middleware::Subdomain, model: "Company", depth: 2)
```

The number is related to the level, so `com` in `www.example.com` is the 1st or `1`.

If you're looking to be flexible in what subdomain you're looking for just tell Groundskeeper how:

``` ruby
...use(Groundskeeper::Middleware::Subdomain, model: "Company", parse: ->(host, depth) {
  if fqdn.end_with?(".awesome.com")
    fqdn.split(".")[depth]
  else
    fqdn.split(".")[-2]
  end
})
```

This tells Groundskeeper to find the tenant's identifier based on the 3rd level subdomain if it ends in `.awesome.com` otherwise look at the 2nd level subdomain.
This is the formula for basing tenancy on subdomain or custom domain name.


**NOTE**: Parameter and Header are currently not written.

Installing
==========

Add this line to your application's Gemfile:

    gem "groundskeeper", "~> 1.0"

And then execute:

    $ bundle

Or install it yourself with:

    $ gem install groundskeeper


Contributing
============

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create new Pull Request


Licensing
=========

Copyright (c) 2014 Kurtis Rainbolt-Greene

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
