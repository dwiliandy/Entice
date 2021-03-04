# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("customer")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_many :carts
  has_many :comments
  has_many :comment_replies
  has_one :wallet
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: {customer: 0, admin: 1}

  #validate collumn
  validates :password, :presence => true,
    :confirmation => true,
    :length => {:within => 6..40},
    :on => :create
  validates :password, :confirmation => true,
    :length => {:within => 6..40},
    :allow_blank => true,
    :on => :update
  validates :name, presence: true
  validates :phone_number, presence: true,
    :numericality => true,
    :length => { :minimum => 10, :maximum => 15 }
  validates :address, presence: true
  #end validate collumn

  after_create :made_wallet
  # after_create :send_welcome_letter

  def made_wallet
  	Wallet.create(nominal: 0, user: self)
  end 

  # def send_welcome_letter
  #   ModelMailer.welcome_email(self).deliver
  # end
end
