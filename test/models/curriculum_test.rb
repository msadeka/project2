require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:camps)

  # test validations
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive

  should allow_value(2872).for(:min_rating)
  should allow_value(0).for(:min_rating)
  should_not allow_value(nil).for(:min_rating)
  should_not allow_value(3001).for(:min_rating)
  should_not allow_value(-1).for(:min_rating)
  should_not allow_value(535.354).for(:min_rating)
  should_not allow_value("abcd").for(:min_rating)

  should allow_value(0).for(:max_rating)
  should allow_value(2872).for(:max_rating)
  should_not allow_value(nil).for(:max_rating)
  should_not allow_value(3001).for(:max_rating)
  should_not allow_value(50).for(:max_rating)
  should_not allow_value(-1).for(:max_rating)
  should_not allow_value(534.43).for(:max_rating)
  should_not allow_value("abcd").for(:max_rating)

    # max greater than min rating
  should "shows that max rating is greater than min rating" do
    medium = FactoryBot.build(:curriculum, name: "c1", min_rating: 500, max_rating: 500)
    deny medium.valid?
  end

  context "Within context" do
    setup do 
      create_curriculums
    end
    
    teardown do
      delete_curriculums
    end

    # scope 'alphabetical'
    should "shows that there are three curriculums in in alphabetical order" do
      assert_equal ["Endgame Principles", "Mastering Chess Tactics", "No Curriculum"], Curriculum.alphabetical.all.map(&:name), "#{Curriculum.class}"
    end
    
    # scope 'active'
    should "shows that there are two active curriculums" do
      assert_equal 2, Curriculum.active.size
      assert_equal ["Endgame Principles", "Mastering Chess Tactics"], Curriculum.active.all.map(&:name).sort, "#{Curriculum.methods}"
    end
    
    # scope 'active'
    should "shows that there is one inactive curriculum" do
      assert_equal 1, Curriculum.inactive.size
      assert_equal ["No Curriculum"], Curriculum.inactive.all.map(&:name).sort
    end

    # scope 'for_rating'
    should "shows that there is a working for_rating scope" do
      assert_equal 3, Curriculum.for_rating(800).size
      assert_equal ["Endgame Principles"], Curriculum.for_rating(1000).all.map(&:name).sort
    end

  end
end
