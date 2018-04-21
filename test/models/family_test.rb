require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  should belong_to(:user)
  should have_many(:students)
  should have_many(:registrations).through(:students)

 
  should validate_presence_of(:family_name)
  should validate_presence_of(:parent_first_name)

  context "Within context" do
    setup do 
      create_family_users
      create_families
      create_inactive_families
    end
    
    # teardown do
    #   delete_families
    #   delete_inactive_families
    #   delete_family_users
    # end
    
    should "sort families in alphabetical order" do
      assert_equal ["Bad", "Darwish", "Mohammed", "Sadeka"], Family.alphabetical.all.map(&:family_name)
    end

    should "return active families" do
     
      assert_equal ["Darwish", "Mohammed", "Sadeka"], Family.active.all.map(&:family_name).sort
    end
    
    should "return inactive family" do
      assert_equal ["Bad"], Family.inactive.all.map(&:family_name).sort
    end


    
  should "remove upcoming registrations when family is made inactive" do
      create_curriculums
      create_locations
      create_camps
      create_students
      create_registrations
      assert_equal 1, @sadeka_family.registrations.count
      @sadeka_family.make_inactive
      @sadeka_family.reload
      assert_equal 0, @sadeka_family.registrations.count
    end


   should "show that families cannot be destroyed" do
      assert_not @mohammed_family.destroy
    end
    
end
end