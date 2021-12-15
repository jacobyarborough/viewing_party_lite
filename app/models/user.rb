class User < ApplicationRecord
  has_many :invites
  has_many :parties, dependent: :destroy
  has_secure_password 

  validates_presence_of :password_digest, :name, :email, uniqueness: true

  def invitations
    invites.joins(:party).select('invites.user_id as invitee_id, parties.*')
  end 
end
