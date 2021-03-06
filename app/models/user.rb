class User < ApplicationRecord
  has_secure_password
    
  # validations
  validates :username, presence: true, uniqueness: { case_sensitive: false}
  validates :role, inclusion: { in: %w[admin instructor parent]}
  validates_presence_of :password, on: :create 
  validates_presence_of :password_confirmation, on: :create 
  validates_confirmation_of :password, message: "does not match"
  validates_length_of :password, minimum: 4, allow_blank: true
  validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil))\z/i
  
  # callbacks
  before_save :phone_to_s
  
  private
  # strips off the non-numbers from the phone number and saves it
  def phone_to_s
    self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
  end
    
  
end
