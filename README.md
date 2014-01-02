# fluent-plugin-split

Output Split String Plugin for fluentd

## Installation

### td-agent(Linux)

    /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-plugin-split

### td-agent(Mac)

    sudo /usr/local/Cellar/td-agent/1.1.XX/bin/fluent-gem install fluent-plugin-split

### fluentd only

    gem install fluent-plugin-split


## parameter

param    |   value
--------|------
output_tag|output tag(require)
output_key|output split word key(require)
format|csv or tsv or space(default csv)
key_name|target key name(require)
keep_keys|keep keys comma separator(optional)

## Configuration

Example:

    <match foo.bar>
      type split
      output_tag split.keyword
      output_key keyword
      format csv
      key_name keywords
      keep_keys site
    </match>

Assume following input is coming:

```js
foo.bar {"keywords"=>"keyword1,keyword2,keyword3", "site" => "google", "user_id" => "1"}
```

then output becomes as below (indented):

```js
split.keyword { "keyword" => "keyword1", "site" => "google"}
split.keyword { "keyword" => "keyword2", "site" => "google"}
split.keyword { "keyword" => "keyword3", "site" => "google"}
```

## ChangeLog

See [CHANGELOG.md](CHANGELOG.md) for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2013 Hiroshi Toyama. See [LICENSE](LICENSE) for details.
