require File.dirname(__FILE__) + '/helper'

class OpPlusEqualNodeTest < NodeTestCase
  def test_to_sexp
    resolve = ResolveNode.new('foo')
    number  = NumberNode.new(10)
    node = OpPlusEqualNode.new(resolve, number)
    assert_sexp([:op_plus_equal, [:resolve, 'foo'], [:lit, 10]], node)
  end
end
