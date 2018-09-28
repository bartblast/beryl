require 'capybara/minitest'

class TmpCapybaraTest < Minitest::Test
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  def test_capybara
    visit('/')
    click_link('invalid-link')
    assert true
  end
end