require 'test/unit'
require_relative '../lib/enumerator_generate'

class TestEnumerate < Test::Unit::TestCase
  def test_enumerate
    enum = Enumerator.generate(1, &:succ)
    assert_instance_of(Enumerator, enum)
    assert_equal(nil, enum.size)
    assert_equal([1, 2, 3, 4], enum.take(4))
    assert_raise(ArgumentError) { Enumerator.generate(1) }
  end

  def test_enumerate_argless
    data = %w[foo bar baz]
    enum = Enumerator.generate { data.pop }
    assert_instance_of(Enumerator, enum)
    assert_equal(nil, enum.size)
    assert_equal(%w[baz bar foo], enum.take_while { |w| !w.nil? })
  end
end
