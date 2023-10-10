# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can(:manage, :all) if user.is_admin?

    can [:manage], Account, :user_id => user.id
    can [:manage], Policy,  :account_id => user.account_ids

    can [:index], Policy

    policy_ids = user.accounts.collect &:policy_ids

    can [:new], Request
    can [:manage], Request, :policy_id => policy_ids.flatten

    can :index, PolicyFinancial
  end
end
