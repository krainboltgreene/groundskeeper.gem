USING
-----

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
