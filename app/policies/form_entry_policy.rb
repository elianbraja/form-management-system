# frozen_string_literal: true

class FormEntryPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(:form).where(forms: { user: user })
    end
  end

  def csv_export?
    # User must be the creator of the form
    record.form.user == user
  end

  def create?
    # User must be the creator of the form
    record.form.user == user
  end

  def new?
    create?
  end

  def edit?
    # User must be the creator of the form
    record.form.user == user
  end

  def update?
    edit?
  end
end
