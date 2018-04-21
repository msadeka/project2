class Curriculum < ApplicationRecord
  

  # relationships
  has_many :camps

  # validations
  validates :name, presence: true , uniqueness: { case_sensitive: false }
  ratings_array = [0] + (100..3000).to_a
  validates :min_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validates :max_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validate :max_more_than_min

  # scopes
  scope :alphabetical, -> { order('name') }               # curriculums in alphabetical order
  scope :active, -> { where(active: true) }               # active curriculums
  scope :inactive, -> { where(active: false) }            # inactive curriculums
  scope :for_rating, ->(rating) { where("min_rating <= ? and max_rating >= ?", rating, rating) }  # curriculums within the rating

   before_destroy :check_if_curriculum_can_be_destroyed
   before_update :check_for_registrations_before_curriculum_deactivation
   
   def check_if_curriculum_can_be_destroyed
     errors.add(:curriculum , "cannot be destroyed")
     throw(:abort)
   end
  
  private
  def max_more_than_min
    return true if self.max_rating.nil? || self.min_rating.nil?
    unless self.max_rating > self.min_rating
      errors.add(:max_rating, "cannot be less than min rating")
    end
  end


end
