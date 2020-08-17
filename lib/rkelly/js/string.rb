module RECMA
  module JS
    class String < Base
      class << self
        def create(*args)
          new(args.first || '')
        end
      end

      def initialize(value)
        super()
        self['valueOf'] = value
        self['valueOf'].function = -> { value }
        self['toString'] = value
        self['fromCharCode'] = unbound_method(:fromCharCode) do |*args|
          args.map { |x| x.chr }.join
        end
      end
    end
  end
end
