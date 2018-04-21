require 'test_helper'
require 'base64'

class RegistrationTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:student)
  should belong_to(:camp)
  should have_one(:family).through(:student)

  
  should validate_numericality_of(:camp_id).only_integer.is_greater_than(0)
  should validate_numericality_of(:student_id).only_integer.is_greater_than(0)

  # set up context
  context "Within context" do
    setup do 
      create_family_users
      create_families
      create_students
      create_curriculums
      create_locations
      create_camps
      create_registrations
    end
    
    # should "have an alphabetical scope" do
    #   assert_equal [ "Sadeka, Salma", "Mohammed, Ahmed"], Registration.alphabetical.all.map{|r| r.student.name}
    # end

  
  
    # should "check student is active in the system" do
    #   create_inactive_students
    #   example = FactoryBot.build(:registration, student: @salma, camp: @ap_camp)
    #   assert_not example.valid?
    #   example = FactoryBot.build(:registration, student: @ahmed, camp: @ec_camp)
    #   assert_not example.valid?
    # end

    # should "check camp is active in the system" do
     
    # example = FactoryBot.build(:registration, student: @ahmed, camp: @ec_camp)
    #   assert_not example.valid?
    # end

    # should "check that the student is within the range" do
    #   # verify that Sean (rating 1252) can register for endgames (700-1500)
    #   ahmed_r = FactoryBot.build(:registration, student: @ahmed, camp: @ec_camp)
    #   assert ahmed_r.valid?
    #   salma_r = FactoryBot.build(:registration, student: @salma, camp: @ap_camp)
    #   assert_not salma_r.valid?
    # end

    # should "detect valid and invalid expiration dates" do
        
    #   @salma_r.expiration_year = Date.current.year
    #   assert @salma_r.valid?
    #   @salma_r.credit_card_number = "78934678889012"
    #   @salma_r.expiration_month = Date.current.month
    #   @salma_r.expiration_year = 7.year.ago.year
    #   assert_not @salma_r.valid?
    # end

    # should "have a properly formatted payment receipt that only is generated once" do
    #   @ahmed_r.payment = nil
    #   assert @ahmed_r.save
    #   @ahmed_r.credit_card_number = "4123456789012"
    #   @ahmed_r.expiration_month = Date.current.month + 1
    #   @ahmed_r.expiration_year = Date.current.year
    #   assert @ahmed_r.valid?
    #   # test that payment receipt created
    #   @ahmed_r.pay
    #   assert_equal "camp: #{@ahmed_r.camp_id}; student: #{@ahmed_r.student_id}; amount_paid: #{@ahmed_r.camp.cost}****#{@ahmed_r.credit_card_number[-4..-1]}", Base64.decode64(@ahmed_r.payment)
     
    # end


   
  end
end