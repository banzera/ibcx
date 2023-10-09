class Account < ApplicationRecord

  belongs_to :user

  has_many :policies

  encrypts :password

  def service_adapter
    MTL.instance_for(self)
  end
end
