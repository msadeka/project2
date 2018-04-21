require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_secure_password

  # validating username
  should validate_presence_of(:username)

  # validating role
  should allow_value("admin").for(:role)
  should allow_value("instructor").for(:role)
  should allow_value("parent").for(:role)
  should_not allow_value("notarole").for(:role)
  should_not allow_value(10).for(:role)
  should_not allow_value(nil).for(:role)

  #validating email
  should allow_value("sam@sam.com").for(:email)
  should allow_value("msadeka@andrew.cmu.edu").for(:email)
  should allow_value("sam_sam@sam.org").for(:email)
  should allow_value("sam3@sam.gov").for(:email)
  should allow_value("my.sam@asfc.net").for(:email)
  should_not allow_value("samiha").for(:email)
  should_not allow_value("com@bethere.con").for(:email)
  should_not allow_value(nil).for(:email)
  
  # validating phone
  should allow_value("4122683259").for(:phone)
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("badnumber").for(:phone)
  should_not allow_value("111/222/4444").for(:phone)
  should_not allow_value(nil).for(:phone)
  
  
  include Contexts
  context "Within context" do
    setup do
      create_users
    end

    should "require users to have unique, case-insensitive usernames" do
      assert_equal "oali", @osama_user.username
      @osama_user.username = "username_changed"
      deny @osama_user.valid?, "#{@osama_user.username}"
    end

    # password must be the same as the one set prior
    should "allow user to authenticate with password" do
      assert @osama_user.authenticate("doIcare")
      deny @osama_user.authenticate("lol")
    end

    #password cannot be kept blank or nil
    should "require a password for new users" do
      notauser_user = FactoryBot.build(:user, username: "oali", password: nil)
      deny notauser_user.valid?
    end
    
    # first time and second time password must be the same
    should "require passwords to be confirmed and matching" do
      nota_user = FactoryBot.build(:user, username: "preethag", password: "doIcare", password_confirmation: nil)
      deny nota_user.valid?
    end
    
    # password must be atleast 4 characters minimum
    should "require passwords to be at least four characters" do
      nota_user = FactoryBot.build(:user, username: "preethag", password: "no4")
      deny nota_user.valid?
    end

    # the blanks can be stripped from the number
    should "strip non-digits from the phone number" do
      assert_equal "666-111-2222", @preetha_user.phone
    end
    
    teardown do
      delete_users
    end

  end
end