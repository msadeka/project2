module Contexts
  module UserContexts
    def create_users
      @samiha_user = FactoryBot.create(:user, username: "samiha", role: "instructor" , phone: "1235678910", email: "msadeka@qatar.cmu.edu", password: "passed", password_confirmation: "passed" )
      @sadia_user  = FactoryBot.create(:user, username: "sadia", role: "parent", phone: "1234567890" , email: "sadia@qatar.cmu.edu", password: "passed1", password_confirmation: "passed1")
      @alex_user   = FactoryBot.create(:user, username: "alex", role: "instructor", phone: "555-666-7777", email: "alex@qatar.cmu.edu", password: "passed2", password_confirmation: "passed2")
      @rachel_user = FactoryBot.create(:user, username: "rachel", role: "instructor", phone: "111-333-5555", email: "rachel@qatar.cmu.edu", password: "passed3", password_confirmation: "passed3")
    end

    def delete_users
      @samiha_user.delete
      @sadia_user.delete
      @alex_user.delete
      @rachel_user.delete
   
    end

   
    def create_family_users
      @samihaf_user = FactoryBot.create(:user, username: "samiha", role: "parent", phone: "555-555-5555", email: "msadeka@qatar.cmu.edu", password: "passed4" , password_confirmation: "passed4")
      @sadiaf_user   = FactoryBot.create(:user, username: "sadia", role: "parent", phone: "666-666-6666", email: "sadia@qatar.cmu.edu", password: "passed4" , password_confirmation: "passed4")
    
    end

    def delete_family_users
      @samihaf_user.delete
      @sadiaf_user.delete
     
    end
  end
end