require 'test/unit'
require 'rubygems'
require 'redgreen'
require 'formulae'

class FormulaeTest < Test::Unit::TestCase
  def test_weighted_mean
    assert_equal 0.5, weighted_mean([2,2], [1,1])
  end
  
  def test_tanimoto_coefficient
    assert_equal 0.4, tanimoto_coefficient( %w[ shirt shoes pants socks ], %w[ shirt skirt shoes ] )
  end
end
