class PrestationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def home?
    true
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    record == user
  end
end
