module RECMA
  class Runtime
    class RubyFunction
      def initialize(&block)
        @code = block
      end

      def call(_chain, *args)
        @code.call(*args)
      end
    end
  end
end
