module Logstash
  module Helpers

    INDENT = '  '

    class << self
      def file_from_config(input, filter, output)
        res = ''
        res << string_from_config_hash('input', input)
        res << string_from_config_hash('filter', filter)
        res << string_from_config_hash('output', output)
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

      def string_from_config_hash(name, config_hash)
        if config_hash && !config_hash.empty?
          vals = config_hash.map do |_, conf|
            if conf.is_a?(String)
              conf + "\n"
            else
              # in this case, it better be a Hash, but its node attributes,
              # so lets make a copy
              conf = conf.dup
              enabled = conf.delete('enabled')

              # nil is the default...  we only care about other falsy values
              if enabled.nil? || enabled
                string_from_attrs(conf)
              end
            end
          end.compact.join("\n")

          indented = vals.gsub(/^(?!$)/, "#{INDENT}")

          "#{name} {\n#{indented}\n}\n\n"
        else
          ''
        end
      end

    end

  end
end
