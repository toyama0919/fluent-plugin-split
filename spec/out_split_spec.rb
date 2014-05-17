# encoding: UTF-8
require 'spec_helper'

class SplitOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  def create_driver(conf = CONFIG, tag = 'test')
    d = Fluent::Test::BufferedOutputTestDriver.new(Fluent::SplitOutput, tag).configure(conf)
    d
  end

  def test_configure_error
    assert_raise(Fluent::ConfigError) do
      d = create_driver %[
        output_key keyword
        format csv
        key_name keywords
        keep_keys site
      ]
    end

    # not define output_key
    assert_raise(Fluent::ConfigError) do
      d = create_driver %[
        output_tag split.keyword
        format csv
        key_name keywords
        keep_keys site
      ]
    end

    # not define output_key
    assert_raise(Fluent::ConfigError) do
      d = create_driver %[
        output_key keyword
        output_tag split.keyword
        format csv
        keep_keys site
      ]
    end

    assert_raise(Fluent::ConfigError) do
      d = create_driver %[
        output_tag split.keyword
        output_key keyword
      ]
    end
  end

  def test_configure
    # not define format(default csv)
    assert_nothing_raised(Fluent::ConfigError) do
      d = create_driver %[
        output_tag split.keyword
        output_key keyword
        key_name keywords
        keep_keys site
      ]
    end

    assert_nothing_raised(Fluent::ConfigError) do
      d = create_driver %[
        output_tag split.keyword
        output_key keyword
        key_name keywords
      ]
    end
  end
end
