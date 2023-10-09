class RepaymentRequest # < ApplicationRecord
  extend ActiveModel::Naming
  include ActiveModel::Attributes
  include ActiveModel::AttributeAssignment
  include ActiveModel::Conversion

  delegate_missing_to :@policy

  attribute :amount,    :integer, default: 500
  attribute :dom,       :integer, default: 1
  attribute :beginning, :date, default: -> { Time.current }

  def initialize(policy)
    @policy = policy
    super()
  end

  def persisted? = false

end
