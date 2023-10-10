class Policy < ApplicationRecord
  include Olivander::Resources::AutoFormAttributes

  auto_resource_fields #columns: 4

  belongs_to :account

  has_many :retrievals

  has_many :details,    through: :retrievals, class_name: 'PolicyDetail',    dependent: :destroy
  has_many :financials, through: :retrievals, class_name: 'PolicyFinancial', dependent: :destroy

  def current_details
    retrievals.order(created_at: :desc).take.details
  end

  def current_financials
    retrievals.order(created_at: :desc).take.financials
  end
end
