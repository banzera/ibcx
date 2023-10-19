class LoanRequest # < ApplicationRecord
  extend ActiveModel::Naming
  include ActiveModel::Attributes
  include ActiveModel::AttributeAssignment
  include ActiveModel::Conversion

  delegate_missing_to :@policy

  attribute :amount,    :integer, default: 500
  attribute :email,     :string
  attribute :phone,     :string

  def initialize(policy)
    @policy = policy
    super()
  end

  def persisted? = false

end
