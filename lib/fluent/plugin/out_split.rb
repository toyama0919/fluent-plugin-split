module Fluent
  class SplitOutput < Output
    Fluent::Plugin.register_output('split', self)

    def initialize
      super
    end

    config_param :output_tag, :string
    config_param :output_key, :string
    config_param :format, :string, :default => "csv"
    config_param :key_name, :string
    config_param :keep_keys, :string, :default => ""

    def configure(conf)
      super
      @keep_keys_array = @keep_keys.split(",")
      if @format == "csv"
        @separator = ','
      elsif @format == "tsv"
        @separator = '\t'
      elsif @format == "space"
        @separator = /[\s　]/
      else
        @separator = @format
      end
    end

    def emit(tag, es, chain)
      es.each { |time, record|
        record[@key_name].split(@separator).each{|item|
          result = {@output_key => item}
          record.each {|key,value|
            result[key] = value if @keep_keys_array.include?(key)
          }
          Engine.emit(output_tag, time, result)
        }
      }
      chain.next
    rescue => e
      $log.warn e.message
      $log.warn e.backtrace.join(', ')
    end
  end
end
