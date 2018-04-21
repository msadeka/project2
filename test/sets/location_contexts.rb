module Contexts
  module LocationContexts
    def create_active_locations
      @ec = FactoryBot.create(:location, name: "Education City", street_1: "Al Gharrafa", street_2: nil, city: "Doha", zip: "11111")
      @rt = FactoryBot.create(:location) 
    end

    def delete_active_locations
      @ec.delete
      @rt.delete
    end

    def create_inactive_locations
      @ap = FactoryBot.create(:location, name: "Aspire Park", street_1: "Al Rayyan", street_2: nil, city: "Doha", zip: "22222", active: false)
    end

    def delete_inactive_locations
      @ap.delete
    end

    def create_locations_never_used_by_camps
      @notused = FactoryBot.create(:location, name: "Not Used", street_1: "Location", street_2: nil, city: "Inland", zip: "33333")
    end

    def delete_locations_never_used_by_camps
      @notused.delete
    end

    def create_locations
      create_active_locations
      create_inactive_locations
      create_locations_never_used_by_camps
    end

    def delete_locations
      delete_active_locations
      delete_inactive_locations
      delete_locations_never_used_by_camps
    end
  end
end