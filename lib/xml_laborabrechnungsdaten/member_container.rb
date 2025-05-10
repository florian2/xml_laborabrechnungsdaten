module XmlLaborabrechnungsdaten
  module MemberContainer
    def self.included(base)
      base.instance_variable_set :@members, {}
      base.extend ClassMethods
    end

    def initialize(**kwargs)
      self.class.after_initialize.each do |block|
        instance_eval(&block)
      end

      kwargs.each do |k, v|
        self[k] = v
      end
    end

    def members
      self.class.instance_variable_get :@members
    end

    def [](key)
      send(key)
    end

    def []=(key, value)
      send(members[key].fetch(:setter_name), value)
    end

    module ClassMethods
      # @param [String] member_name
      # @param [Array<Class>, Class] type
      # @param [Object] default
      # @param [TrueClass, FalseClass] optional When true, omits tag rather than rendering an empty tag on nil
      # @param [Proc] transform_value A Proc which is called with the input value to perform type conversion.
      def member(member_name, type: nil, default: nil, optional: false, transform_value: nil)
        attr_reader member_name
        setter_name           = :"#{member_name}="
        @members[member_name] = { optional: optional, setter_name: setter_name }

        if default
          after_initialize do
            send(setter_name, default)
          end
        end

        define_method setter_name do |in_value|
          in_value = transform_value.call(in_value) if transform_value

          if type && !in_value.nil? && Array(type).none? { |t| in_value.is_a?(t) }
            raise ArgumentError, "expected #{type} for :#{member_name}, got: #{in_value.class}"
          end

          instance_variable_set :"@#{member_name}", in_value
        end
      end

      def after_initialize(&block)
        @after_initialize_blocks ||= []
        if block
          @after_initialize_blocks << block
        else
          @after_initialize_blocks
        end
      end
    end
  end
end
