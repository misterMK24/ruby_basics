module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instance_counter
    end

    def increase_instance_counter
      @instance_counter += 1
    end

    protected

    def declare_instance_counter
      @instance_counter = 0
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.increase_instance_counter
    end
  end
end
