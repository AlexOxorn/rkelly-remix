module RKelly
  module JS
    class Base
      attr_reader :properties, :return, :value
      def initialize
        @properties = Hash.new do |h, k|
          h[k] = Property.new(k, :undefined, self)
        end
        @return     = nil
        @returned   = false
        @value      = self
        self['Class'] = self.class.to_s.split('::').last
      end

      def [](name)
        return properties[name] if has_property?(name)

        if properties['prototype'].value != :undefined
          properties['prototype'].value[name]
        else
          RKelly::Runtime::UNDEFINED
        end
      end

      def []=(name, value)
        return unless can_put?(name)

        if has_property?(name)
          properties[name].value = value
        else
          properties[name] = Property.new(name, value, self)
        end
      end

      def can_put?(name)
        unless has_property?(name)
          return true if properties['prototype'].nil?
          return true if properties['prototype'].value.nil?
          return true if properties['prototype'].value == :undefined

          return properties['prototype'].value.can_put?(name)
        end
        !properties[name].read_only?
      end

      def has_property?(name)
        return true if properties.has_key?(name)
        return false if properties['prototype'].nil?
        return false if properties['prototype'].value.nil?
        return false if properties['prototype'].value == :undefined

        properties['prototype'].value.has_property?(name)
      end

      def delete(name)
        return true unless has_property?(name)
        return false if properties[name].dont_delete?

        properties.delete(name)
        true
      end

      def default_value(hint)
        case hint
        when 'Number'
          value_of = self['valueOf']
          return value_of if value_of.function || value_of.value.is_a?(RKelly::JS::Function)

          to_string = self['toString']
          return to_string if to_string.function || to_string.value.is_a?(RKelly::JS::Function)
        end
      end

      def return=(value)
        @returned = true
        @return = value
      end

      def returned?
        @returned
      end

      private

      def unbound_method(name, object_id = nil, &block)
        name = "#{name}_#{self.class.to_s.split('::').last}_#{object_id}"
        unless RKelly::JS::Base.instance_methods.include?(name.to_sym)
          RKelly::JS::Base.class_eval do
            define_method(name, &block)
          end
        end
        RKelly::JS::Base.instance_method(name)
      end
    end
  end
end
