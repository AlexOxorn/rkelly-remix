require 'rkelly/js/base'
require 'rkelly/js/nan'

module RKelly
  module JS
    class Number < Base
      def initialize()
        super()
        self['MAX_VALUE'] = 1.797693134862315e+308
        self['MIN_VALUE'] = 1.0e-306
        self['NaN']       = JS::NaN.new
        self['POSITIVE_INFINITY'] = 1.0/0.0
        self['NEGATIVE_INFINITY'] = -1.0/0.0
      end
    end
  end
end
