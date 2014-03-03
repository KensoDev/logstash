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

  describe '.file_from_config' do
    let(:input) do
      [
        {
          file: {
            type: 'testing',
            paths: %w(some file paths/testing)
          }
        },
        "if [something] == true {\n  do_something { test => true }\n}",
        {
          file: {
            type: 'again',
            path: 'my/file/path'
          }
        }
      ]
    end

    let(:output) do
      [
        {
          test: {
            out: true
          }
        }
      ]
    end

    subject(:result) { described_class.file_from_config(input, nil, output) }

    it 'serializes the file' do
      expected = <<-EOF
input {
  file {
    type => "testing"
    paths => ["some", "file", "paths/testing"]
  }

  if [something] == true {
    do_something { test => true }
  }

  file {
    type => "again"
    path => "my/file/path"
  }

}

output {
  test {
    out => true
  }

}

EOF

      expect(result).to eq(expected)
    end
  end
end
