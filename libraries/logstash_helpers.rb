module Logstash
  module Helpers

    INDENT = '  '

    class << self
      def file_from_config(input, filter, output)
        res = ''
        res << string_from_config_hash('input', input)
        if filter
          filter_section = LogstashConf.section_to_str(filter)
          res << "filter {\n#{filter_section}\n}\n\n" if filter_section && !filter_section.empty? #string_from_config_hash('filter', filter)
        end
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

    #
    # totally ripping this from the community cookbook
    #
    class LogstashConf
      def self.key_to_str(k)
        case k.class.to_s
        when 'String'
          return "'#{k}'"
        when 'Fixnum', 'Float'
          return k.to_s
        when 'Regex'
          return k.inspect
        end
        return k
      end

      def self.hash_to_str(h, indent = 0)
        result = []
        h.each do |k, v|
          indent += 4
          result << indent(indent) + key_value_to_str(k, v, indent)
          indent -= 4
        end
        result.join("\n")
      end

      def self.value_to_str(v, indent = 0)
        case v
        when String, Symbol, Fixnum, Float
          "\"#{v}\""
        when Array
          "[#{v.map { |e| value_to_str(e, indent) }.join(', ')}]"
        when Hash, Mash
          "{\n" + hash_to_str(v, indent) + "\n" + indent(indent) + '}'
        when TrueClass, FalseClass
          v.to_s
        else
          v.inspect
        end
      end

      def self.key_value_to_str(k, v, indent = 0)
        if v.nil?
          key_to_str(k)
        else
          # k.inspect + " => " + v.inspect
          key_to_str(k) + ' => ' + value_to_str(v, indent)
        end
      end

      def self.plugin_to_arr(plugin, patterns_dir_plugins = nil, patterns_dir = nil, indent = 0) # , type_to_condition)
        result = []
        plugin.each do |name, hash|
          indent += 4
          result << indent(indent) + name.to_s + ' {'
          result << indent(indent) + key_value_to_str('patterns_dir', patterns_dir, indent) if patterns_dir_plugins.include?(name.to_s) && patterns_dir && !hash.key?('patterns_dir')
          hash.sort.each do |k, v|
            indent += 4
            result << indent(indent) + key_value_to_str(k, v, indent)
            indent -= 4
          end
          result << indent(indent) + '}'
          indent -= 4
        end
        return result.join("\n")
      end

      def self.section_to_str(section, version = nil, patterns_dir = nil, indent = 0)
        result = []
        patterns_dir_plugins = ['grok']
        patterns_dir_plugins << 'multiline' if Gem::Version.new(version) >= Gem::Version.new('1.1.2') unless version.nil?
        section.each do |_, segment|
          result << ''
          if segment.key?('condition') || segment.key?('block')
            indent += 4
            result << indent(indent) + segment['condition'] + ' {' if segment['condition']
            result << plugin_to_arr(segment['block'], patterns_dir_plugins, patterns_dir, indent)
            result << indent(indent) + '}' if segment['condition']
            indent -= 4
          else
            indent += 4
            result << plugin_to_arr(segment, patterns_dir_plugins, patterns_dir, indent) # , type_to_condition)
            indent -= 4
          end
        end
        return result.join("\n")
      end

      def self.indent(i)
        res = ''
        i.times { res << ' ' }
        res
      end
    end

  end
end
