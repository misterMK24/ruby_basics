module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_arr_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_arr_history, []) if instance_variable_get(var_arr_history).nil?
        instance_variable_get(var_arr_history).push(instance_variable_get(var_name))
        instance_variable_set(var_name, value)
      end
      define_method("#{name}_history") { instance_variable_get(var_arr_history) }
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Wrong value type' unless value.is_a? class_name

      instance_variable_set(var_name, value)
    end
  end
end
