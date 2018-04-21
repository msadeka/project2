require 'test_helper'

class CampInstructorTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:camp)
  should belong_to(:instructor)

  # test validations
  should validate_presence_of(:camp_id)
  should validate_presence_of(:instructor_id)
  should validate_numericality_of(:camp_id).only_integer.is_greater_than(0)
  should validate_numericality_of(:instructor_id).only_integer.is_greater_than(0)
end
