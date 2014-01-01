# encoding: UTF-8
require_relative 'spec_helper'

describe Fluent::SplitOutput do
  before { Fluent::Test.setup }
  CONFIG = %[
    type split
    output_tag split.keyword
    output_key keyword
    format csv
    key_name keywords
    keep_keys object_type
  ]

end
