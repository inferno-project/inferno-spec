module Inferno
  class Interface
    class << self

      def implemented_in?(instance)
        class_method_errors = []
        instance_method_errors = []

        @_class_methods.each do |meth|
          class_method_errors << meth.match?(instance.class)
        end

        @_instance_methods.each do |meth|
          instance_method_errors << meth.match?(instance)
        end

        if class_method_errors.any? || instance_method_errors.any?
          puts "#{instance.class.name} not implements #{self.class.name}. Here is why:\n"
          (class_method_errors + instance_method_errors).compact.each do |error|
            puts error
          end
        end
      end

    protected

      def def_instance_method(name, *args)
        @_instance_methods ||= []
        @_instance_methods << InterfaceMethod.new(name, *args)
      end

      def def_class_method(name, *args)
        @_class_methods ||= []
        @_class_methods << InterfaceMethod.new(name, *args)
      end

    end
  end

  class InterfaceMethod

    attr_reader :name, :args, :block, :ret_type

    def match?(obj)
      errors = []
      begin
        meth = obj.method(name)
      rescue
        return "No such method: #{name}"
      end

      unless meth.parameters == args
        return "Method params mismatch in #{name}. Expected: #{args} Got: #{meth.parameters}"
      end

      nil
    end

  private

    def initialize(name, *args)
      options   = args.last.is_a?(Hash) ? args.pop : {}

      @name     = name
      @ret_type = options.delete(:return)
      @args     = args
    end
  end

end