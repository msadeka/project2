class Location < ApplicationRecord

  # relationships
  has_many :camps

  # states list that can be allowed
  STATES_LIST = [['Alabama', 'AL'],['Alaska', 'AK'],['Arizona', 'AZ'],['Arkansas', 'AR'],['California', 'CA'],['Colorado', 'CO'],['Connectict', 'CT'],['Delaware', 'DE'],['District of Columbia ', 'DC'],['Florida', 'FL'],['Georgia', 'GA'],['Hawaii', 'HI'],['Idaho', 'ID'],['Illinois', 'IL'],['Indiana', 'IN'],['Iowa', 'IA'],['Kansas', 'KS'],['Kentucky', 'KY'],['Louisiana', 'LA'],['Maine', 'ME'],['Maryland', 'MD'],['Massachusetts', 'MA'],['Michigan', 'MI'],['Minnesota', 'MN'],['Mississippi', 'MS'],['Missouri', 'MO'],['Montana', 'MT'],['Nebraska', 'NE'],['Nevada', 'NV'],['New Hampshire', 'NH'],['New Jersey', 'NJ'],['New Mexico', 'NM'],['New York', 'NY'],['North Carolina','NC'],['North Dakota', 'ND'],['Ohio', 'OH'],['Oklahoma', 'OK'],['Oregon', 'OR'],['Pennsylvania', 'PA'],['Rhode Island', 'RI'],['South Carolina', 'SC'],['South Dakota', 'SD'],['Tennessee', 'TN'],['Texas', 'TX'],['Utah', 'UT'],['Vermont', 'VT'],['Virginia', 'VA'],['Washington', 'WA'],['West Virginia', 'WV'],['Wisconsin ', 'WI'],['Wyoming', 'WY']]

  # validations
  validates :name, presence: true #, uniqueness: { case_sensitive: false }
  validates :street_1, presence: true
  validates :state, inclusion: { in: STATES_LIST.map{|a,b| b}, message: "is not valid state", allow_blank: true }
  validates :zip, presence: true, format: { with: /\A\d{5}\z/, message: "should be five digits long", allow_blank: true }
  validates :max_capacity, presence: true, numericality: { only_integer: true, greater_than: 0, allow_blank: true }
  
  # scopes
  scope :alphabetical, -> { order('name') }      # locations in alphabetical order
  scope :active, -> { where(active: true) }      # active locations
  scope :inactive, -> { where(active: false) }   # inactive locations
  
  before_destroy :check_if_active_locations
  
  private
  def check_if_active_locations
      flag = 1
      self.camps.map do |camp|
          if camp.end_date < Date.today     #checks for past camps
              flag = 0
          end
      end
      if (flag == 0)                        # does not destroy camps that have been active in the past
          errors.add(:location, "unable to destroy camp")
          throw(:abort)
      end
  end
end
