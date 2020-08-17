module RECMA
  module JS
    class Object < Base
      attr_reader :value
      class << self
        def create(*args)
          arg = args.first
          return new if arg.nil? || arg == :undefined

          case arg
          when true, false
            JS::Boolean.new(arg)
          when Numeric
            JS::Number.new(arg)
          when ::String
            JS::String.new(arg)
          else
            new(arg)
          end
        end
      end

      def initialize(*args)
        super()
        self['prototype'] = JS::ObjectPrototype.new
        self['valueOf'] = -> { args.first || self }
        self['valueOf'].function = -> { args.first || self }
      end
    end
  end
end
