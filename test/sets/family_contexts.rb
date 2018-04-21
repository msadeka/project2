module Contexts
  module FamilyContexts
  
    def create_families
      @sadeka_user = FactoryBot.create(:user, username: "sadeka", role: "parent", phone: "123-567-8910", email: "sadeka@qatar.cmu.edu" , password: "passed", password_confirmation: "passed")
      @mohammed_user = FactoryBot.create(:user, username: "mohammed", role: "parent", phone: "111-222-3333", email: "mohammed@qatar.cmu.edu" , password: "passed1" ,password_confirmation: "passed1" )
      @darwish_user   = FactoryBot.create(:user, username: "darwish", role: "admin" ,phone: "222-333-4444", email: "darwish@qatar.cmu.edu" , password: "passed2" , password_confirmation: "passed2" )
        
      @sadeka_family = FactoryBot.create(:family, user: @sadeka_user, family_name: "Sadeka" , active: true)
      @mohammed_family  = FactoryBot.create(:family, user: @mohammed_user, family_name: "Mohammed", parent_first_name: "Ahmed", active: true)
      @darwish_family = FactoryBot.create(:family, user: @darwish_user, family_name: "Darwish", parent_first_name: "Cyrene", active: true)
      
    end

    def delete_families
      @sadeka_family.delete
      @mohammed_family.delete
      @darwish_family.delete
    end

    def create_inactive_families
      @bad_user   = FactoryBot.create(:user, username: "baduser", role: "admin", active: false , password: "failed" , phone: "1247890987" , password_confirmation: "failed", email: "notauser@qatar.cmu.edu")
      @bad_family = FactoryBot.create(:family, user: @bad_user, family_name: "Bad", parent_first_name: "Notaa", active: false)
    end

    def delete_inactive_families
      @bad_family.delete
    end
  end
end