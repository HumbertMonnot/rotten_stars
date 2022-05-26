class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    # Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
