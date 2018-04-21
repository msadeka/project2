module Contexts
  module RegistrationContexts

    def create_registrations
      @samiha_tactics    = FactoryBot.create(:registration, camp: @camp1, student: @samiha)
      @israt_endgames = FactoryBot.create(:registration, camp: @camp4, student: @israt)
      @zahir_tactics  = FactoryBot.create(:registration, camp: @camp1, student: @zahir)
      @umar_endgames  = FactoryBot.create(:registration, camp: @camp4, student: @umar)
      @yusuf_endgames = FactoryBot.create(:registration, camp: @camp4, student: @yusuf)
    end

    def delete_registrations
      @samiha_tactics.delete
      @israt_endgames.delete
      @zahir_tactics.delete
      @umar_endgames.delete
      @yusuf_endgames.delete
    end
  end
end