module RECMA
  module JS
    class Array < Base
      class << self
        def create(*args)
          new(*args)
        end
      end

      def initialize(*_args)
        super()
      end
    end
  end
end
