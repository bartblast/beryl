require 'test_helper'
require 'beryl/deserializer'

class DeserializerTest < Minitest::Test
  class TestClass1
    attr_accessor :a
    attr_accessor :b
  end

  class TestClass2
    attr_accessor :x
    attr_accessor :y
  end

  def test_array_of_integers
    serialized = '[{"class":"Integer","value":"1"},{"class":"Integer","value":"2"}]'
    assert Beryl::Deserializer.deserialize(serialized) == [1, 2]
  end

  def test_array_of_composite_objects
    serialized = '[{"class":"SerializerTest::TestClass1","value":{"@a":{"class":"Integer","value":"1"},"@b":{"class":"Integer","value":"2"}}},{"class":"SerializerTest::TestClass1","value":{"@a":{"class":"Integer","value":"3"},"@b":{"class":"Integer","value":"4"}}}]'
    obj_1 = TestClass1.new
    obj_1.a = 1
    obj_1.b = 2
    obj_2 = TestClass1.new
    obj_2.a = 3
    obj_2.b = 4
    result = Beryl::Deserializer.deserialize(serialized)
    assert result.class == Array
    assert result.size == 2
    assert result[0].class == SerializerTest::TestClass1
    assert result[0].a == 1
    assert result[0].b == 2
    assert result[1].class == SerializerTest::TestClass1
    assert result[1].a == 3
    assert result[1].b == 4
  end

  def test_array_of_symbol_and_hash
    serialized = '[{"class":"Symbol","value":"symbol"},{"class":"Hash","value":{"key_1":{"class":"Integer","value":"1"},"key_2":{"class":"Integer","value":"2"}}}]'
    assert Beryl::Deserializer.deserialize(serialized) == [:symbol, key_1: 1, key_2: 2]
  end

  def test_composite_object
    serialized = '{"class":"SerializerTest::TestClass1","value":{"@a":{"class":"Integer","value":"1"},"@b":{"class":"Integer","value":"2"}}}'
    obj = TestClass1.new
    obj.a = 1
    obj.b = 2
    result = Beryl::Deserializer.deserialize(serialized)
    assert result.class == SerializerTest::TestClass1
    assert result.a == 1
    assert result.b == 2
  end

  def test_composite_object_with_nested_array_of_integers
    serialized = '{"class":"SerializerTest::TestClass1","value":{"@a":[{"class":"Integer","value":"1"},{"class":"Integer","value":"2"}],"@b":{"class":"Integer","value":"2"}}}'
    obj = TestClass1.new
    obj.a = [1, 2]
    obj.b = 2
    result = Beryl::Deserializer.deserialize(serialized)
    assert result.class == SerializerTest::TestClass1
    assert result.a == [1, 2]
    assert result.b == 2
  end

  def test_composite_object_with_nested_composite_object
    serialized = '{"class":"SerializerTest::TestClass2","value":{"@x":{"class":"SerializerTest::TestClass1","value":{"@a":{"class":"Integer","value":"1"},"@b":{"class":"Integer","value":"2"}}},"@y":{"class":"Integer","value":"2"}}}'
    obj_1 = TestClass1.new
    obj_1.a = 1
    obj_1.b = 2
    obj_2 = TestClass2.new
    obj_2.x = obj_1
    obj_2.y = 2
    result = Beryl::Deserializer.deserialize(serialized)
    assert result.class == SerializerTest::TestClass2
    assert result.x.class == SerializerTest::TestClass1
    assert result.x.a == 1
    assert result.x.b == 2
    assert result.y == 2
  end

  def test_float
    serialized = '{"class":"Float","value":"1.1"}'
    assert Beryl::Deserializer.deserialize(serialized) == 1.1
  end

  def test_integer
    serialized = '{"class":"Integer","value":"1"}'
    assert Beryl::Deserializer.deserialize(serialized) == 1
  end

  def test_string
    serialized = '{"class":"String","value":"string"}'
    assert Beryl::Deserializer.deserialize(serialized) == 'string'
  end

  def test_symbol
    serialized = '{"class":"Symbol","value":"symbol"}'
    assert Beryl::Deserializer.deserialize(serialized) == :symbol
  end
end