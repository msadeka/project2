module Contexts
  module InstructorContexts
    def create_instructors
      @alex   = FactoryBot.create(:instructor, first_name: "Alex", last_name: "Mark", bio: nil, active: true)
      @rachel = FactoryBot.create(:instructor, first_name: "Rachel", last_name: "Taylor", bio: nil, active: false)
      
      
    end

   
   
  end
end