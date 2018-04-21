class Instructor < ApplicationRecord
    
  # relationships
  has_many :camp_instructors
  has_many :camps, through: :camp_instructors

  # validations
  validates_presence_of :first_name
  validates_presence_of :last_name

  # scopes
  scope :alphabetical, -> { order('last_name, first_name') }  # instructors in alphabetical order
  scope :needs_bio, -> { where(bio: nil) }                    # instructors that have no bio
  scope :active, -> {where(active: true)}                     # active instructors
  scope :inactive, -> {where(active: false)}                  # inactive instructors

  # class method that returns instructors for the camp
  def self.for_camp(camp)
    CampInstructor.where(camp_id: camp.id).map{ |ci| ci.instructor }
  end
  
  # instance methods
  def name
    last_name + ", " + first_name
  end
  
  def proper_name
    first_name + " " + last_name
  end
end
