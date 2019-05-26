require 'yaml'
module KTE
  class Template
    attr_reader :file_path, :key, :opts
    def initialize(file_path, key = nil, opts = {})
      @file_path = get_file_path(file_path)
      @key = key
      @opts = opts
    end

    def value
      check_file!
      check_yaml!
      return yml unless keys
      keys.inject(yml) do |prev, nxt|
        begin
          prev.fetch(nxt)
        rescue
          raise WrongKey, "for file: #{file_path} with key: #{key}"
        end
      end
    end
    alias_method :to_h, :value

    def result(inst)
      ERB.new(value.to_yaml).result(inst.instance_eval {binding})
    end

    def file_exists?
      File.exists?(file_path)
    end

    def key_exists?
      value.class <= Hash
    rescue WrongKey
      false
    end

    def valid_yaml?
      check_yaml!
      true
    rescue NotValidYaml
      false
    end

    def valid?
      validate!
      true
    rescue *self.class.errors
      false
    end

    def validate!
      check_file! && check_yaml! && value
    end

    private

    def check_file!
      raise WrongFile, "File does not exists at: #{file_path}" unless file_exists?
    end

    def check_yaml!
      if yml.class <= Hash; true
      else raise NotValidYaml, "Not valid YAML at #{file_path}"
      end
    rescue
      raise NotValidYaml, "Not valid YAML at #{file_path}"
    end

    def get_file_path(file_path)
      file_path.to_s =~ /.yml$/ ? file_path : "#{file_path}.erb.yml"
    end

    def yml
      @yml ||= YAML.load(file_content)
    end

    def file_content
      @file_content ||= File.read(file_path)
    end

    def keys
      key ? key.split('.') : nil
    end
    class WrongKey < StandardError; end
    class WrongFile < StandardError; end
    class WrongValue < StandardError; end
    class NotValidYaml < StandardError; end

    def self.errors
      [
        WrongKey,
        WrongFile,
        WrongValue,
        NotValidYaml
      ]
    end
  end
end
