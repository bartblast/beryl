require 'test_helper'
require 'serializer'

class SerializerTest < Minitest::Test
  class TestClass1
    attr_accessor :a
    attr_accessor :b
  end

  class TestClass2
    attr_accessor :x
    attr_accessor :y
  end

  def test_array_of_integers
    assert Serializer.serialize([1, 2]) == '[{"class":"Integer","value":"1"},{"class":"Integer","value":"2"}]'
  end

  def test_array_of_composite_objects
    obj_1 = TestClass1.new
    obj_1.a = 1
    obj_1.b = 2
    obj_2 = TestClass1.new
    obj_2.a = 3
    obj_2.b = 4
    expected = '[{"class":"SerializerTest::TestClass1","value":{"@a":{"class":"Integer","value":"1"},"@b":{"class":"Integer","value":"2"}}},{"class":"SerializerTest::TestClass1","value":{"@a":{"class":"Integer","value":"3"},"@b":{"class":"Integer","value":"4"}}}]'
    assert Serializer.serialize([obj_1, obj_2]) == expected
  end

  def test_array_of_symbol_and_hash
    obj = [:symbol, key_1: 1, key_2: 2]
    expected = '[{"class":"Symbol","value":"symbol"},{"class":"Hash","value":{"key_1":{"class":"Integer","value":"1"},"key_2":{"class":"Integer","value":"2"}}}]'
    assert Serializer.serialize(obj) == expected
  end

  def test_composite_object
    obj = TestClass1.new
    obj.a = 1
    obj.b = 2
    expected = '{"class":"SerializerTest::TestClass1","value":{"@a":{"class":"Integer","value":"1"},"@b":{"class":"Integer","value":"2"}}}'
    assert Serializer.serialize(obj) == expected
  end

  def test_composite_object_with_nested_array_of_integers
    obj = TestClass1.new
    obj.a = [1, 2]
    obj.b = 2
    expected = '{"class":"SerializerTest::TestClass1","value":{"@a":[{"class":"Integer","value":"1"},{"class":"Integer","value":"2"}],"@b":{"class":"Integer","value":"2"}}}'
    assert Serializer.serialize(obj) == expected
  end

  def test_composite_object_with_nested_composite_object
    obj_1 = TestClass1.new
    obj_1.a = 1
    obj_1.b = 2
    obj_2 = TestClass2.new
    obj_2.x = obj_1
    obj_2.y = 2
    expected = '{"class":"SerializerTest::TestClass2","value":{"@x":{"class":"SerializerTest::TestClass1","value":{"@a":{"class":"Integer","value":"1"},"@b":{"class":"Integer","value":"2"}}},"@y":{"class":"Integer","value":"2"}}}'
    assert Serializer.serialize(obj_2) == expected
  end

  def test_float
    assert Serializer.serialize(1.1) == '{"class":"Float","value":"1.1"}'
  end

  def test_integer
    assert Serializer.serialize(1) == '{"class":"Integer","value":"1"}'
  end

  def test_string
    assert Serializer.serialize('string') == '{"class":"String","value":"string"}'
  end

  def test_symbol
    assert Serializer.serialize(:symbol) == '{"class":"Symbol","value":"symbol"}'
  end
end