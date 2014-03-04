module Logstash
  module Helpers

    INDENT = '  '

    class << self
      def file_from_config(input, filter, output)
        res = ''
        res << string_from_config_array('input', input)
        res << string_from_config_array('filter', filter)
        res << string_from_config_array('output', output)
        res
      end

      def string_from_attrs(attrs, level = 0)
        attrs.each_with_object('') do |(k, v), s|
          s << (INDENT * level) + k.to_s + string_for_value(v, level) + "\n"
        end
      end

      private

      def string_for_value(val, level = 0)
        case val
        when Hash
          nested = string_from_attrs(val, level + 1).chomp # get rid of last newline
          indent = INDENT * level
          prefix = level == 0 ? '' : ' =>'
          "#{prefix} {\n#{nested}\n#{indent}}"
        when String
          " => \"#{val}\""
        else
          " => #{val.to_s}"
        end
      end

      def string_from_config_array(name, config)
        if config && !config.empty?
          vals = config.map do |c|
            if c.is_a?(String)
              c + "\n"
            else
              string_from_attrs(c)
            end
          end.join("\n")

          indented = vals.gsub(/^(?!$)/, "#{INDENT}")

          "#{name} {\n#{indented}\n}\n\n"
        else
          ''
        end
      end

    end

  end
end
