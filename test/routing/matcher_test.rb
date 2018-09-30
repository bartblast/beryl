require 'test_helper'
require 'beryl/routing/matcher'
require 'beryl/routing/router'

class MatcherTest < Minitest::Test
  def test_matching
    puts "result = #{Beryl::Routing::Matcher.match('/abc/:dupa/xyz/:sth', '/abc/123/xyz/987').inspect}"
  end

  def test_2
    r = Beryl::Routing::Router.new
    puts "RESULT"
    puts r.match('/blog/3434').inspect
    puts 'END'
  end
end