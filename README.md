# fluent-plugin-split

Output Split String Plugin for fluentd

## Installation

Use RubyGems:

    /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-plugin-split


## parameter

param    |   value
--------|------
output_tag|output tag
output_key|output split word key
format|csv or tsv or space
key_name|target key name
keep_keys|keep keys(comma separator)

## Configuration

Example:

    <match tag>
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
split.keyword { "keyword":"keyword1", "site" => "google"}
split.keyword { "keyword":"keyword2", "site" => "google"}
split.keyword { "keyword":"keyword3", "site" => "google"}
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
