class RepaymentRequest # < ApplicationRecord
  extend ActiveModel::Naming
  include ActiveModel::Attributes
  include ActiveModel::AttributeAssignment
  include ActiveModel::Conversion

  delegate_missing_to :@policy

  attribute :amount,               :integer, default: 500
  attribute :day_of_month,         :integer, default: 1
  attribute :deduction_begin_date, :date, default: -> { Date.today }

  attribute :financial_institution

  def initialize(policy)
    @policy = policy
    super()
  end

  def persisted? = false

end
