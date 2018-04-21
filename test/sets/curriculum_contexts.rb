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

    def create_more_curriculums
      @cur1         = FactoryBot.create(:curriculum, name: "Curriculum 1", min_rating: 1000, max_rating: 2500, description: "Best curriculum", active: false)
      @cur2         = FactoryBot.create(:curriculum, name: "Curriculum 2", min_rating: 10, max_rating: 500, description: "Only for kids")
      @cur3         = FactoryBot.create(:curriculum, name: "Curriculum 3", min_rating: 2000, max_rating: 3000, description: "Expert Curriculum")
      @cur4         = FactoryBot.create(:curriculum, name: "Curriculum 4", min_rating: 10, max_rating: 2800, description: "Only for adults")
    end

    def delete_more_curriculums
      @cur1.delete
      @cur2.delete
      @cur3.delete
      @cur4.delete
    end
  end
end