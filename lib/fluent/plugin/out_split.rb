# -*- encoding : utf-8 -*-
module Fluent
  class SplitOutput < Output
    Fluent::Plugin.register_output('split', self)

    # Define `router` method of v0.12 to support v0.10 or earlier
    unless method_defined?(:router)
      define_method("router") { Fluent::Engine }
    end

    unless method_defined?(:log)
      define_method(:log) { $log }
    end

    def initialize
      super
    end

    config_param :output_tag, :string
    config_param :output_key, :string
    config_param :format, :string, default: 'csv'
    config_param :key_name, :string
    config_param :keep_keys, :string, default: ''

    def configure(conf)
      super
      @keep_keys_array = @keep_keys.split(',')
      if @format == 'csv'
        @separator = ','
      elsif @format == 'tsv'
        @separator = '\t'
      elsif @format == 'space'
        @separator = /[\s　]/
      else
        @separator = @format
      end
    end

    def emit(tag, es, chain)
      es.each do |time, record|
        next if record[@key_name].nil?
        record[@key_name].split(@separator).each do|item|
          result = { @output_key => item }
          record.each do|key, value|
            result[key] = value if @keep_keys_array.include?(key)
          end
          router.emit(output_tag, time, result)
        end
      end
      chain.next
    rescue => e
      log.warn e.message
      log.warn e.backtrace.join(', ')
    end
  end
end
