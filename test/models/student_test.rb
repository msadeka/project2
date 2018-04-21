require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  should belong_to(:family)
  should have_many(:registrations)
 
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:family_id)
  should validate_numericality_of(:family_id).only_integer.is_greater_than(0)
  
  should allow_value(10.years.ago.to_date).for(:date_of_birth)
  should_not allow_value(Date.today).for(:date_of_birth)
  should_not allow_value(100.day.from_now.to_date).for(:date_of_birth)
  should_not allow_value("abcd").for(:date_of_birth)
  should_not allow_value(100).for(:date_of_birth)
  should_not allow_value(1.1323).for(:date_of_birth)

  should allow_value(100).for(:rating)
  should allow_value(0).for(:rating)
  should allow_value(nil).for(:rating)
  should_not allow_value(4000).for(:rating)
  should_not allow_value(-100).for(:rating)
  should_not allow_value(8.40).for(:rating)
  should_not allow_value("abcd").for(:rating)

  context "Within context" do
    setup do 
      create_families
      create_students
      create_family_users
      create_inactive_students
      create_inactive_families
    end
    
    should "order students in alphabetical order" do
      assert_equal ["Bad, Good", "Mohammed, Ahmed", "Sadeka, Salma"], Student.alphabetical.all.map(&:name)
    end
    
    should "have below_rating scope" do 
      assert_equal 2, Student.below_rating(1000).size
      assert_equal ["Ahmed", "Salma"], Student.below_rating(1000).all.map(&:first_name).sort  
      assert_equal 2, Student.below_rating(3000).size
      assert_equal ["Ahmed", "Salma"], Student.below_rating(3000).all.map(&:first_name).sort
    end

    should "have at_or_above_rating scope" do
      assert_equal 0, Student.at_or_above_rating(2000).size
      assert_equal [], Student.at_or_above_rating(1000).all.map(&:first_name).sort      
    end
    
    should "return active students" do
      assert_equal 2, Student.active.size
      assert_equal ["Ahmed", "Salma"], Student.active.all.map(&:first_name).sort
    end
    
    should "return inactive students" do
      assert_equal 1, Student.inactive.size
      assert_equal ["Good"], Student.inactive.all.map(&:first_name).sort
    end
    
    should "show that name method works" do
      assert_equal "Sadeka, Salma", @salma.name
      assert_equal "Mohammed, Ahmed", @ahmed.name
    end
    
    should "show that proper_name method works" do
      assert_equal "Ahmed Mohammed", @ahmed.proper_name
      assert_equal "Salma Sadeka", @salma.proper_name
    end
    
    should "check the student with no rating has default set to zero" do
      @nil_user    = FactoryBot.create(:user, username: "nil", role: "admin", active: false , password: "donee" , password_confirmation: "donee", phone: "111-111-1111" , email: "nil@qatar.cmu.edu")
      @nill        = FactoryBot.create(:family, user: @nil_user, family_name: "Nil", parent_first_name: "Nillll", active: false)
      @nil_student = FactoryBot.create(:student, family: @nill, first_name: "Nill", last_name: "Nill", date_of_birth: 25.years.ago.to_date, active: false, rating: nil)
      assert_equal nil, @nil_student.rating
    end
    
    should "have an  age method" do 
      assert_equal 18, @ahmed.age 
      assert_equal 21, @salma.age  
    end
  end
end