module Contexts
  module StudentContexts
    def create_students
      @samiha = FactoryBot.create(:student, family: @siddiq, rating: 100)
      @israt  = FactoryBot.create(:student, family: @siddiq, first_name: "Israt", last_name: "Siddiq", date_of_birth: 15.years.ago.to_date, rating: 10)
      @zahir  = FactoryBot.create(:student, family: @siddiq, first_name: "Zahir", last_name: "Siddiq", date_of_birth: 2.years.ago.to_date, rating: 500)      
      @umar   = FactoryBot.create(:student, family: @khan, first_name: "Umar", last_name: "Khan", date_of_birth: 4.years.ago.to_date, rating: 1800)
      @yusuf  = FactoryBot.create(:student, family: @khan, first_name: "Yusuf", last_name: "Khan", date_of_birth: 2.weeks.ago.to_date, rating: 300)
      @sheikh = FactoryBot.create(:student, family: @khan, first_name: "Sheikh", last_name: "Khan", date_of_birth: 7.years.ago.to_date, rating: 1000)
    end

    def delete_students
      @samiha.delete
      @israt.delete
      @zahir.delete
      @umar.delete
      @yusuf.delete
      @sheikh.delete
    end

    def create_inactive_students
      @inactstudent = FactoryBot.create(:student, family: @khan, first_name: "Inactstudent", last_name: "Khan", date_of_birth: 2.years.ago.to_date, active: false, rating: nil)
    end

    def delete_inactive_students
      @inactstudent.delete
    end
  end
end