module Logstash
  module Helpers

    INDENT = '  '

    class << self
      def string_from_attrs(attrs, level = 0)
        attrs.each_with_object('') do |(k, v), s|
          s << (INDENT * level) + k.to_s + string_for_value(v, level) + "\n"
        end
      end

      def string_for_value(val, level = 0)
        case val
        when Hash
          nested = string_from_attrs(val, level + 1).chomp # get rid of last newline
          " {\n#{nested}\n#{INDENT * level}}"
        when String
          " => \"#{val}\""
        else
          " => #{val.to_s}"
        end
      end
    end

  end
end
