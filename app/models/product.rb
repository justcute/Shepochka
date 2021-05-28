class Product < ApplicationRecord
  has_one_attached :avatar
  after_initialize :set_defaul_parameters, :if => :new_record?

  validates :title, presence: true
  validates :body, presence: true
  validates :avatar, presence: true

  def set_defaul_parameters
      self.parameter1 ||= 0
      self.parameter2 ||= 0
      self.parameter3 ||= 0
      self.parameter4 ||= 0
      self.parameter5 ||= 0
      self.rating ||= 0
  end

  def self.search(search)
    if search != "" && search
      Product.where(title: search)
    else
      Product.all
    end
  end
end
