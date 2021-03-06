class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    # Be explicit about which records you allow access to!
    def resolve
      {
        launched: scope.all.select { |resa| resa.user == user },
        received: scope.all.select { |resa| resa.prestation.user == user },
      } 
    end
  end

  def update?
    record.prestation.user == user
  end
end
