module Contexts
  module RegistrationContexts

    def create_registrations
      
      @expert = FactoryBot.create(:curriculum, name: "Expert", min_rating: 800, max_rating: 3000, active: true)
      @advanced = FactoryBot.create(:curriculum, name: "Advanced", min_rating: 1000, max_rating: 2000, active: true)
      
      @ec = FactoryBot.create(:location, name: 'Education City',  street_1: 'Al Rayyan' , max_capacity: 50, zip: 12345 , active: true) 
      @ap = FactoryBot.create(:location, name: 'Aspire Park',  street_1: 'Al Gharrafa' , max_capacity: 100, zip: 54321 , active: true)
       
      @ec_camp = FactoryBot.create(:camp, curriculum: @expert, start_date: Date.new(2018,10,9), end_date: Date.new(2018,10,25),  time_slot: "pm", location: @ec , active: true , cost: 100.0)
      @ap_camp = FactoryBot.create(:camp, curriculum: @advanced, start_date: Date.new(2018,10,19), end_date: Date.new(2018,10,25), time_slot: "am", location: @ap , active: true , cost: 200.0)
        
      @ahmed_r = FactoryBot.create(:registration, camp: @ec_camp, student: @ahmed)
      @salma_r = FactoryBot.create(:registration, camp: @ap_camp, student: @salma)
     
    end

    def delete_registrations
      @ahmed_r.delete
      @salma_r.delete
    end
    
  end
end