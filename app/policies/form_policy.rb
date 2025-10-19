# frozen_string_literal: true

class FormPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    record.user == user
  end

  def update?
    show?
  end

  def edit?
    update?
  end

  def destroy?
    show?
  end
end
