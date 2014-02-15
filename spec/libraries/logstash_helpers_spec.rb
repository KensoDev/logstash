require 'spec_helper'
require './libraries/logstash_helpers'

describe Logstash::Helpers do

  describe '.string_from_attrs' do
    let(:test_data) do
      {
        input: {
          string: 'a str',
          number: 1,
          boolean: true
        },
        output: {
          array: %w[some array of strings],
          hash: {
            nested: true
          }
        }
      }
    end

    let(:result) { described_class.string_from_attrs(test_data) }

    it 'serializes the keys' do
      expected = <<-EOF
input {
  string => "a str"
  number => 1
  boolean => true
}
output {
  array => ["some", "array", "of", "strings"]
  hash {
    nested => true
  }
}
EOF

      expect(result).to eq(expected)
    end
  end
end
