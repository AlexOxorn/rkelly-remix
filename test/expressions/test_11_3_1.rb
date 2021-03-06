require File.dirname(__FILE__) + '/../helper'

class Expressions_11_3_1_Test < ECMAScriptTestCase
  def test_uninitialized
    @runtime.execute('var MYVAR; assert_equal(NaN, MYVAR++); assert_equal(NaN, MYVAR);')
  end

  @@tests = [
    undefined: ['(void 0)', 'NaN', 'NaN'],
    null: %w[null 0 1],
    true: %w[true 1 2],
    false: %w[false 0 1],
    positive_infinity: ['Number.POSITIVE_INFINITY',
                        'Number.POSITIVE_INFINITY',
                        'Number.POSITIVE_INFINITY'],
    negative_infinity: ['Number.NEGATIVE_INFINITY',
                        'Number.NEGATIVE_INFINITY',
                        'Number.NEGATIVE_INFINITY'],
    nan: ['Number.NaN', 'Number.NaN', 'Number.NaN'],
    zero: %w[0 0 1],
    boolean_false: ['new Boolean(false)', '0', '1'],
    boolean_true: ['new Boolean(true)', '1', '2'],
    string_string: ["'string'", 'Number.NaN', 'Number.NaN'],
    number_s: ["'12345'", '12345', '12346'],
    negative_s: ["'-12345'", '-12345', '-12344'],
    hex_s: ["'0Xf'", '15', '16'],
    num_0_s: ["'077'", '77', '78'],
    empty_s: ["''", '0', '1'],
    obj_string_string: ['new String("string")', 'Number.NaN', 'Number.NaN'],
    obj_string_num: ['new String("12345")', '12345', '12346'],
    obj_negative: ['new String("-12345")', '-12345', '-12344'],
    obj_hex: ['new String("0Xf")', '15', '16'],
    obj_0_s: ['new String("077")', '77', '78'],
    obj_empty: ['new String("")', '0', '1']
  ]

  def test_positive_float
    @runtime.execute("
                     var MYVAR=0.2345;
                     assert_equal(0.2345, MYVAR++);
                     assert_in_delta(1.2345, MYVAR, 0.00001);
                     ")
  end

  def test_negative_float
    @runtime.execute("
                     var MYVAR=-0.2345;
                     assert_equal(-0.2345, MYVAR++);
                     assert_in_delta(0.7655, MYVAR, 0.00001);
                     ")
  end

  @@tests.each do |testing|
    testing.each do |name, values|
      define_method(:"test_#{name}") do
        @runtime.execute("
                         var MYVAR=#{values[0]};
                         assert_equal(#{values[1]}, MYVAR++);
                         assert_equal(#{values[2]}, MYVAR);
                         ")
      end
    end
  end
end
