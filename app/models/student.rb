class Student < ApplicationRecord
    belongs_to :family
    has_many :registrations
    has_many :camps, through: :registrations
    validates_presence_of :family_id, :first_name, :last_name
    
    validates :family_id, numericality: { only_integer: true, greater_than: 0 }
    validates :rating, numericality: { only_integer: true, allow_blank: true , less_than_or_equal_to: 3000 , greater_than_or_equal_to: 0} 
    validates_date :date_of_birth, :before => lambda { Date.today }, allow_blank: true, on:  :create
    
    
    scope :alphabetical, -> { order('last_name, first_name') }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :below_rating, ->(ceiling) { where('rating < ?', ceiling) }
    scope :at_or_above_rating, ->(floor) { where('rating >= ?', floor) }
    
    before_save :zero_rating_if_blank
    before_update :no_new_registration_if_student_inactive
    
    def name
        "#{self.last_name}, #{self.first_name}"
    end

    def proper_name
        "#{self.first_name} #{self.last_name}"
    end

    def age
        return nil if date_of_birth.blank?
        now = Time.now.to_s(:number).to_i
        now.year - date_of_birth.year(:number).to_i - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end
    
    def zero_rating_if_blank
        self.rating ||= 0
    end
    
    def no_new_registration_if_student_inactive
        return true if !self.active and self.registrations.empty?
        newres = self.registrations.select{|res| res.camp.start_date >= Date.current}
        newres.each{ |nr| nr.destroy }
    end

end