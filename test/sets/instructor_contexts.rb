module Contexts
  module InstructorContexts
    def create_instructors
      @saquib   = FactoryBot.create(:instructor)
      @khaled   = FactoryBot.create(:instructor, first_name: "Khaled", bio: nil, phone: "444-444-4444")
      @kemal    = FactoryBot.create(:instructor, first_name: "Kemal", bio: nil, active: false)
    end

    def delete_instructors
      @saquib.delete
      @khaled.delete
      @kemal.delete
    end

    def create_more_instructors
      @selma  = FactoryBot.create(:instructor, first_name: "Selma", last_name: "Mansar", bio: "Professor", email: "selmal@example.com")
      @chadi  = FactoryBot.create(:instructor, first_name: "Chadi", last_name: "Aoun", bio: "Professor")
      @lal    = FactoryBot.create(:instructor, first_name: "Ligin", last_name: "Lal", bio: "Professor")
    end

    def delete_more_instructors
      @selma.delete
      @chadi.delete
      @lal.delete
    end
  end
end