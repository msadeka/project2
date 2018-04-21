require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  should have_many(:camps)

  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive
  should validate_presence_of(:street_1)
  should validate_presence_of(:zip)
  should validate_presence_of(:max_capacity)

  should allow_value("12345").for(:zip)
  should allow_value("54321").for(:zip)
  should_not allow_value("1234").for(:zip)
  should_not allow_value("123456").for(:zip)
  should_not allow_value("abcd").for(:zip)

  should allow_value("PA").for(:state)  #allow for states mentioned in the model itself
  should allow_value("WV").for(:state)
  should allow_value("OH").for(:state)
  should allow_value("CA").for(:state)
  should_not allow_value("bad").for(:state)
  should_not allow_value(10).for(:state)
  
  should allow_value(10).for(:max_capacity)
  should_not allow_value(0).for(:max_capacity)
  should_not allow_value(-10).for(:max_capacity)
  should_not allow_value(2.132).for(:max_capacity)
  should_not allow_value("abcd").for(:max_capacity)

  context "Within context" do
    setup do 
      create_active_locations
    end
    
    teardown do
      delete_active_locations
    end

    should "show two locations in in alphabetical order" do
      assert_equal ["Carnegie Mellon", "Education City"], Location.alphabetical.all.map(&:name)
    end

    should "show two active locations and one inactive location" do
      create_inactive_locations
      assert_equal ["Carnegie Mellon", "Education City"], Location.active.all.map(&:name).sort
      assert_equal ["Aspire Park"], Location.inactive.all.map(&:name).sort
      delete_inactive_locations
    end

  end
end
