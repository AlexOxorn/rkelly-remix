class ExecuteTestCase < Test::Unit::TestCase
  include RECMA::Nodes

  undef :default_test if method_defined? :default_test

  def assert_execute(expected, code)
    scope_chain = @runtime.execute(code)
    expected.each do |name, value|
      assert scope_chain.has_property?(name)
      assert_equal value, scope_chain[name].value
    end
  end
end
