module Contexts
  module CurriculumContexts
    def create_curriculums
      @tactics    = FactoryBot.create(:curriculum)
      @endgames   = FactoryBot.create(:curriculum, name: "Endgame Principles", min_rating: 700, max_rating: 1500)
      @nocur      = FactoryBot.create(:curriculum, name: "No Curriculum", active: false)
    end

    def delete_curriculums
      @tactics.delete
      @endgames.delete
      @nocur.delete
    end

  end
end