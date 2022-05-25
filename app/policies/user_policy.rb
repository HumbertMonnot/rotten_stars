class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    record == user
  end

  def create?
    record == user
  end

  def past_reservations?
    record == user
  end
end
