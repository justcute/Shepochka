class User < ApplicationRecord
  enum role: [:user, :expert, :admin]
  after_initialize :set_defaul_role, :if => :new_record?

  def set_defaul_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
