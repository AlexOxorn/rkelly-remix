class ECMAScriptTestCase < Test::Unit::TestCase
  include RECMA::JS

  undef :default_test if method_defined? :default_test

  def setup
    @runtime = RECMA::Runtime.new
    @runtime.define_function(:assert_equal) do |*args|
      assert_equal(*args)
    end
    @runtime.define_function(:assert_in_delta) do |*args|
      assert_in_delta(*args)
    end
  end

  def js_assert_equal(expected, actual)
    @runtime.execute("assert_equal(#{expected}, #{actual});")
  end
end
