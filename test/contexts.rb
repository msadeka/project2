# require needed files
require './test/sets/curriculum_contexts'
require './test/sets/instructor_contexts'
require './test/sets/camp_contexts'
require './test/sets/camp_instructor_contexts'
require './test/sets/location_contexts'
require './test/sets/student_contexts'
require './test/sets/family_contexts'
require './test/sets/user_contexts'
require './test/sets/registration_contexts'
require './test/sets/credit_card_contexts'


module Contexts
  include Contexts::CurriculumContexts
  include Contexts::LocationContexts
  include Contexts::CampContexts
  include Contexts::InstructorContexts
  include Contexts::CampInstructorContexts
  include Contexts::CampContexts
  include Contexts::StudentContexts
  include Contexts::FamilyContexts
  include Contexts::UserContexts
  include Contexts::RegistrationContexts
  include Contexts::CreditCardContexts
  
  def create_contexts
    create_curriculums
    create_more_curriculums
    create_locations
    create_active_locations
    create_camps
    create_past_camps
    create_upcoming_camps
    create_instructors
    create_more_instructors
    create_camp_instructors
    create_more_camp_instructors
    create_past_camps
    create_students
    create_inactive_students
    create_families
    create_inactive_families
    create_users
    create_family_users
    create_registrations
    create_valid_cards
    create_invalid_card_lengths
    create_invalid_card_prefixes
    create_invalid_card_dates
  end
end


