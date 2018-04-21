module Contexts
  module FamilyContexts
    def create_families
      @siddiq = FactoryBot.create(:family, user: @siddiq_user)
      @khan   = FactoryBot.create(:family, user: @khan_user, family_name: "Khan", parent_first_name: "Aren")
      @basak  = FactoryBot.create(:family, user: @basak_user, family_name: "Basak", parent_first_name: "Paromita")
    end

    def delete_families
      @siddiq.delete
      @khan.delete
      @basak.delete
    end

    def create_inactive_families
      @inactfam = FactoryBot.create(:family, user: @inactfam_user, family_name: "Inactfam", parent_first_name: "Him", active: false)
    end

    def delete_inactive_families
      @inactfam.delete
    end
  end
end