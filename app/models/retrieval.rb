class Retrieval < ApplicationRecord
  include Olivander::Resources::AutoFormAttributes

  belongs_to :policy

  has_many :details,    class_name: 'PolicyDetail',    dependent: :destroy
  has_many :financials, class_name: 'PolicyFinancial', dependent: :destroy


  scope :latest, -> {
    group(:policy).maximum(:id)
  }
end
