class CampInstructor < ApplicationRecord
  
  # relationships
  belongs_to :camp
  belongs_to :instructor

  # validations
  validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :instructor_id, presence: true, numericality: { greater_than: 0, only_integer: true }
  validate :unassigned_instructor, on: :create
  validate :instructor_assigned_at_the_time, on: :create
  validate :active_instructor
  validate :active_camp


  private
  
  # checks if the camp instructor has already been assigned to a camp
  def unassigned_instructor
    return true if self.camp.nil? || self.instructor.nil?
    unless CampInstructor.where(camp_id: self.camp_id, instructor_id: self.instructor_id).to_a.empty?
      errors.add(:base, "Instructor assigned to this camp already")
    end
  end

  # checks if the instructor is assigned to another camp at the same time
  def instructor_assigned_at_the_time
    return true if self.camp.nil? || self.instructor.nil?
    instructors_at_that_time = Camp.where(start_date: self.camp.start_date, time_slot: self.camp.time_slot).map{|c| c.instructors }.flatten
    if instructors_at_that_time.include?(self.instructor)
      errors.add(:base, "Instructor is already assigned")
    end
  end

  # checks if instructor is active in the system
  def active_instructor
    return if self.instructor.nil?
    errors.add(:instructor, "is not active") unless self.instructor.active

  end

  # checks if camp is active in the system
  def active_camp
    return if self.camp.nil?
    errors.add(:camp, "is not active") unless self.camp.active
  end
  
end
