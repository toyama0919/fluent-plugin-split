# encoding: UTF-8
require 'spec_helper'

class SplitOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  def create_driver(conf = CONFIG, tag='test')
    d = Fluent::Test::BufferedOutputTestDriver.new(Fluent::SplitOutput, tag).configure(conf)
    d
  end

  def test_configure_error
    assert_raise(Fluent::ConfigError) {
      d = create_driver %[
        output_key keyword
        format csv
        key_name keywords
        keep_keys site
      ]
    }

    # not define output_key
    assert_raise(Fluent::ConfigError) {
      d = create_driver %[
        output_tag split.keyword
        format csv
        key_name keywords
        keep_keys site
      ]
    }

    # not define output_key
    assert_raise(Fluent::ConfigError) {
      d = create_driver %[
        output_key keyword
        output_tag split.keyword
        format csv
        keep_keys site
      ]
    }

    assert_raise(Fluent::ConfigError) {
      d = create_driver %[
        output_tag split.keyword
        output_key keyword
      ]
    }

  end

  def test_configure
    # not define format(default csv)
    assert_nothing_raised(Fluent::ConfigError) {
      d = create_driver %[
        output_tag split.keyword
        output_key keyword
        key_name keywords
        keep_keys site
      ]
    }

    assert_nothing_raised(Fluent::ConfigError) {
      d = create_driver %[
        output_tag split.keyword
        output_key keyword
        key_name keywords
      ]
    }

  end

end
