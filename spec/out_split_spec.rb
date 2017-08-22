# encoding: UTF-8
require 'spec_helper'

class SplitOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  def create_driver(conf = CONFIG, tag = 'test')
    d = Fluent::Test::OutputTestDriver.new(Fluent::SplitOutput, tag).configure(conf)
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

  def test_emits
    tag = "split.keyword"
    d = create_driver %[
      type split
      output_tag #{tag}
      output_key keyword
      format csv
      key_name keywords
      keep_keys site
    ], "test.split"

    time = Time.now.to_i
    d.run {
      d.emit({"keywords"=>"keyword1,keyword2,keyword3", "site" => "google", "user_id" => "1"}, time)
    }
    assert_equal [[tag, time, {"keyword"=>"keyword1", "site"=>"google"}],
                  [tag, time, {"keyword"=>"keyword2", "site"=>"google"}],
                  [tag, time, {"keyword"=>"keyword3", "site"=>"google"}]], d.emits
  end
end
