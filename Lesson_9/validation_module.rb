module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, validation, param = nil)
      @validations ||= []
      @validations << { name: name, validation: validation, param: param }
    end
  end

  module InstanceMethods
    def validate!
      params = self.class.validations
      params.each do |validate|
        var = instance_variable_get("@#{validate[:name]}".to_sym)
        self.send "validate_#{validate[:validation]}", var, validate[:param]
      end
    end

    private

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def validate_presence(name, _param = nil)
      raise "Name can't be empty or nil" if name.nil? || name.empty?
    end

    def validate_format(name, param)
      raise 'Value has invalid format' if name !~ param
    end

    def validate_type(name, param)
      raise 'Class error' unless name.is_a? param
    end
  end
end
