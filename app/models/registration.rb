class Registration < ApplicationRecord
  require 'base64'
  
  # relationships
  belongs_to :camp
  belongs_to :student
  has_one :family, through: :student
  attr_accessor :credit_card_number , :expiration_month , :expiration_year
  
  # validations
  validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :student_id, presence: true, numericality: { greater_than: 0, only_integer: true }
  validate :active_students, on: :create
  validate :active_camps, on: :create
  validate :student_rating_between_min_max_rating
  validate :valid_cc_number
  validate :exp_date_valid

  # scopes
  scope :for_camp, ->(camp_id) { where(camp_id: camp_id) }          # registrations by camp
  scope :alphabetical, -> { joins(:student).order('students.last_name, students.first_name') }  # alphabetical order by student's name

  # other methods
  
  # returns the payment receipt in the desired string if not paid
  def pay
    if self.payment == nil
    self.payment = Base64.encode64("camp: #{self.camp_id}; student: #{self.student_id}; amount_paid: #{self.camp.cost}****#{self.credit_card_number[-4..-1]}")
    end
  end

 private
 
  def student_rating_between_min_max_rating
    return true if  student_id.nil? || camp_id.nil? 
    unless (student.rating).between?(camp.curriculum.min_rating, camp.curriculum.max_rating)
        errors.add(:base, "Student rating is not between min and max rating")
    end
  end

  # checks if there are any active students in the system by registration
  def active_students
    return if self.student.nil?
    errors.add(:student, "is not active") if !self.student.active
  end

  # checks if there are any active camps in the system by registration
  def active_camps
    return if self.camp.nil?
    errors.add(:camp, "is not active") if !self.camp.active
  end

  # creates a new credit card record
  def credit_card
    CreditCard.new(self.credit_card_number, self.expiration_year, self.expiration_month)
  end

  # checks if the credit card number is valid
  def valid_cc_number
      return false if self.expiration_year.nil? || self.expiration_month.nil?
      if self.credit_card_number.nil? || credit_card.type.nil?
      errors.add(:credit_card_number, "is not valid")
      return false
      end
      true
  end

  # checks if the expiration date of the credit card is valid
  def exp_date_valid
      return false if self.credit_card_number.nil? 
      if self.expiration_year.nil? || self.expiration_month.nil? || credit_card.expired?
        errors.add(:expiration_date, "is expired")
        return false
      end
      true
  end
end
