module RKelly
  module JS
    class String < Base
      def initialize(env)
        super()
        self['fromCharCode'] = Function.new(env) do |this, *args|
          args.map { |x| x.chr }.join
        end
      end
    end
  end
end
