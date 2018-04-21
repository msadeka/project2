module Contexts
  module StudentContexts
      def create_students
        @ahmed = FactoryBot.create(:student, family: @mohammed_family, rating: 10 , first_name: "Ahmed" , last_name: "Mohammed" , date_of_birth: 18.years.ago.to_date)
        @salma = FactoryBot.create(:student, family: @sadeka_family, rating: 210 , first_name: "Salma" , last_name: "Sadeka" , date_of_birth: 21.years.ago.to_date)
      end

      def delete_students
        @ahmed.delete
        @salma.delete
      end

      def create_inactive_students
        @bad_user   = FactoryBot.create(:user, username: "bad", role: "admin", active: false , password: "badagain" , phone: "124-789-0987" , password_confirmation: "badagain", email: "bad@qatar.cmu.edu")
        @bad_family = FactoryBot.create(:family, user: @bad_user, family_name: "Bad", parent_first_name: "Dontcare", active: false)
        @bad_student = FactoryBot.create(:student, family: @bad_family, first_name: "Good", last_name: "Bad", date_of_birth: 22.years.ago.to_date, active: false, rating: nil)
      end

      def delete_inactive_students
        @bads_user
      end
  end
end