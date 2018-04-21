require 'test_helper'

class UserTest < ActiveSupport::TestCase
 should have_secure_password

  
  should validate_presence_of(:username)

  should allow_value("admin").for(:role)
  should allow_value("instructor").for(:role)
  should allow_value("parent").for(:role)
  
  should_not allow_value("anyotherrole").for(:role)
  should_not allow_value(0000).for(:role)
  should_not allow_value(1.100).for(:role)
  
  should allow_value("yno@yahoo.com").for(:email)
  should allow_value("yno@andrew.cmu.edu").for(:email)
  should_not allow_value("yno.con").for(:email)
  should_not allow_value(nil).for(:email)
  
  should allow_value("1234567890").for(:phone)
  should allow_value("(012) 268-3259").for(:phone)
  should_not allow_value("123/456/7890").for(:phone)
  should_not allow_value(nil).for(:phone)
  
  
  context "Within context" do
    setup do
      create_users
    end

    should "return unique username and verify 1" do
      assert_equal "samiha", @samiha_user.username
      @samiha_user.username = "sadeka"
      assert @samiha_user.valid?, "#{@samiha_user.username}"
    end
    
    should "return unique username and verify 2" do
      assert_equal "sadia", @sadia_user.username
      @sadia_user.username = "notaname"
      assert @sadia_user.valid?, "#{@sadia_user.username}"
    end

    should "allow user to authenticate with password 1" do
      assert @samiha_user.authenticate("passed")
      assert_not @samiha_user.authenticate("passed1")
    end
    
    should "allow user to authenticate with password 2" do
      assert @sadia_user.authenticate("passed1")
      assert_not @sadia_user.authenticate("passed")
    end

    should "require a password for new users 1" do
      bad1 = FactoryBot.build(:user, username: "notausers", password: nil)
      assert_not bad1.valid?
    end
    
    should "require a password for new users 2" do
      bad2 = FactoryBot.build(:user, username: "doneee", password: nil)
      assert_not bad2.valid?
    end
    
    should "require passwords to be confirmed and matching 1" do
      bad1 = FactoryBot.build(:user, username: "notausers", password: "matched", password_confirmation: "unmatched")
      assert_not bad1.valid?
    end
    
    should "require passwords to be confirmed and matching 2" do  
      bad2 = FactoryBot.build(:user, username: "nope", password: nil, password_confirmation: "unmatched")
      assert_not bad2.valid?
    end
    
    should "require passwords to be at least four characters 1" do
      bad1 = FactoryBot.build(:user, username: "notausers", password: "nau")
      assert_not bad1.valid?
    end
    
    should "require passwords to be at least four characters 2" do
      bad2 = FactoryBot.build(:user, username: "notausers", password: nil)
      assert_not bad2.valid?
    end

    should "verify the  phone number 1" do
      assert_equal "5556667777", @alex_user.phone
    end
    
    should "verify the  phone number 2" do
      assert_equal "1113335555", @rachel_user.phone
    end
end
end