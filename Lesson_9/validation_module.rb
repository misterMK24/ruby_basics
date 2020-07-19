module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, validation, param = nil)
      @validations ||= { name: [], validations: [], param: [] }
      @validations[:name] << name
      @validations[:validations] << validation
      @validations[:param] << param
    end
  end

  module InstanceMethods
    def validate!
      params = self.class.validations
      params[:validations].each_with_index do |validation, index|
        var = instance_variable_get("@#{params[:name][index]}".to_sym)
        eval("#{validation}(var, params[:param][index])")
      end
    end

    private

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def presence(name, _param = nil)
      raise "Name can't be empty or nil" if name.nil? || name.empty?
    end

    def format(name, param)
      raise 'Value has invalid format' if name !~ param
    end

    def type(name, param)
      raise 'Class error' unless name.is_a? param
    end
  end
end
