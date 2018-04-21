class Student < ApplicationRecord
    
  # relationships
  belongs_to :family
  has_many :registrations
  has_many :camps, through: :registrations
  
  # validations
  validates :first_name , presence: true
  validates :last_name  , presence: true
  validates :family_id  , presence: true ,  numericality: { only_integer: true, greater_than: 0 }
  validates_date :date_of_birth, :before => lambda { Date.today }, allow_blank: true, on: :create
  validates :rating, numericality: { only_integer: true, allow_blank: true , less_than_or_equal_to: 3000 , greater_than_or_equal_to: 0} 
 
  # scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :below_rating, ->(ceiling) { where('rating < ?', ceiling) }
  scope :at_or_above_rating, ->(floor) { where('rating >= ?', floor) }
  
  #methods
 
  # age method extracted from starter code
  def age
    return nil if date_of_birth.blank?
    (Time.now.to_s(:number).to_i - date_of_birth.to_time.to_s(:number).to_i)/10e9.to_i
  end
 
  def name
    "#{self.last_name}, #{self.first_name}"
  end
  
  def proper_name
    "#{self.first_name} #{self.last_name}"
  end
  
end
