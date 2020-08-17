class NodeTestCase < Test::Unit::TestCase
  include RECMA::Nodes

  undef :default_test if method_defined? :default_test

  def assert_sexp(expected, actual)
    assert_equal(expected, actual.to_sexp)
  end
end
