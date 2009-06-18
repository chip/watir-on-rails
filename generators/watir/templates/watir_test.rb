require File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../test_helper'

class <%= class_name %>Test < ActiveSupport::TestCase
  include WatirOnRails
  
  # Uncomment the following lines to specify a test server.
  # WatirOnRails defaults to http://localhost:3000
  #
  # server "localhost"
  # port 3001

  # fixtures :foos, :bars

  def test_nothing_yet
    browser = open_browser("/")
    fail "Need to write my Watir on Rails test"
  end
end
