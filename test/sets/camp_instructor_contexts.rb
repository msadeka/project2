module Contexts
  module CampInstructorContexts
    def create_camp_instructors
      # assumes create_curriculums, create_instructors, create_camps run prior
      @alex_c = FactoryBot.create(:camp_instructor, instructor: @alex, camp: @camp1)
      @rachel_c = FactoryBot.create(:camp_instructor, instructor: @rachel, camp: @camp2)
    end

    def delete_camp_instructors
     
    end

   
  end
end