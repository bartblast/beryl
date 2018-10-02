$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'beryl'
require 'minitest/autorun'

require 'beryl/backend'
require 'capybara'
# Capybara.app = Beryl::Backend.new