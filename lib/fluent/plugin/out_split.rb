# -*- encoding : utf-8 -*-

require 'fluent/plugin/output'

module Fluent::Plugin
  class SplitOutput < Output
    Fluent::Plugin.register_output('split', self)

    helpers :event_emitter

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

    def process(tag, es)
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
    rescue => e
      log.warn e.message
      log.warn e.backtrace.join(', ')
    end
  end
end
