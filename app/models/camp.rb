class Camp < ApplicationRecord
  
  # relationships
  belongs_to :curriculum
  belongs_to :location
  has_many :camp_instructors
  has_many :instructors, through: :camp_instructors
  has_many :registrations
  has_many :students, through: :registrations

  # validations
  validates_presence_of :location_id, :curriculum_id, :time_slot, :start_date
  validates_numericality_of :cost, greater_than_or_equal_to: 0
  validates_date :start_date, :on_or_after => lambda { Date.today }, :on_or_after_message => "start_date must after present", on:  :create
  validates_date :end_date, :on_or_after => :start_date
  validates_inclusion_of :time_slot, in: %w[am pm]
  validates_numericality_of :max_students, only_integer: true, greater_than: 0, allow_blank: true
  validate :active_curriculum
  validate :active_location
  validate :no_duplicate_camp, on: :create
  validate :max_reaches_capacity

  # scopes
  scope :active, -> { where(active: true) }                      #active camps
  scope :inactive, -> { where(active: false) }                   #inactive camps
  scope :alphabetical, -> { joins(:curriculum).order('name') }   #camps in alphabetical order
  scope :chronological, -> { order('start_date','end_date') }    #camps in chronological order
  scope :morning, -> { where('time_slot = ?','am') }             #morning camps
  scope :afternoon, -> { where('time_slot = ?','pm') }           #afternoon camps
  scope :upcoming, -> { where('start_date >= ?', Date.today) }   #upcoming camps 
  scope :past, -> { where('end_date < ?', Date.today) }          #past camps
  scope :for_curriculum, -> (curriculum_id) { where("curriculum_id = ?", curriculum_id) }        #camps with the curriculum
  scope :full, -> { joins(:registrations).group(:camp_id).having('count(*) = max_students') }    #camps with reg count = max_students
  
  

  # instance methods
  def name
    self.curriculum.name
  end

  # checks if a camp at the same time, date and location already exists
  def already_exists?
    Camp.where(time_slot: self.time_slot, start_date: self.start_date, location_id: self.location_id).size == 1
  end

  # checks if the number of registrations has reached its limit
  def is_full?
    self.max_students == self.registrations.count
  end
  
  # returns the number of registrations for the particular camp
  def enrollment
    self.registrations.count
  end
  
 
  # private
  
  # checks if curriculum is active in the system
  def active_curriculum
    return if self.curriculum.nil?
    errors.add(:curriculum, "is not active") unless self.curriculum.active
  end

  # checks if location is active in the system
  def active_location
    return if self.location.nil?
    errors.add(:location, "is not active") unless self.location.active
  end
  
  # verifies the duplicacy of the particular camp
  def no_duplicate_camp
    return true if self.time_slot.nil? || self.start_date.nil? || self.location_id.nil?
    if self.already_exists?
      errors.add(:time_slot, "a camp like this is already there")
    end
  end

  # checks if the maximum number of students has outnumbered the capacity of the location
  def max_reaches_capacity
    return true if self.max_students.nil? || self.location_id.nil?
    if self.max_students > self.location.max_capacity
      errors.add(:max_students, "is more than capacity")
    end
  end
end
