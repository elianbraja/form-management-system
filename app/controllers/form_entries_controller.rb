class FormEntriesController < ApplicationController
  before_action :set_form
  before_action :set_form_entry, only: [:edit, :update]

  def new
    authorize FormEntry.new(form: @form, user: current_user)
    @form_entry_service = FormEntries::CreateService.new(form: @form, user: current_user)
  end

  def create
    authorize FormEntry.new(form: @form, user: current_user)
    @form_entry_service = FormEntries::CreateService.new(form_entry_params.merge(form: @form, user: current_user))
    
    if @form_entry_service.call
      redirect_to form_path(@form), notice: 'Form entry was successfully submitted.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @form_entry
    @form_entry_service = FormEntries::UpdateService.new(form_entry: @form_entry, form: @form, user: current_user)
  end

  def update
    authorize @form_entry
    @form_entry_service = FormEntries::UpdateService.new(form_entry_params.merge(form_entry: @form_entry, form: @form, user: current_user))
    
    if @form_entry_service.call
      redirect_to form_path(@form), notice: 'Form entry was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def csv_export
    authorize FormEntry.new(form: @form, user: current_user)
    csv_service = FormEntries::CsvGenerationService.new(@form)
    
    respond_to do |format|
      format.csv { send_data csv_service.call, filename: csv_service.filename }
    end
  end

  private

  def set_form
    @form = policy_scope(Form).find(params[:form_id])
  end

  def set_form_entry
    @form_entry = @form.form_entries.find(params[:id])
  end

  def form_entry_params
    params.require(:form_entries_update_service).permit(
      field_values: [:form_field_id, :value]
    )
  rescue ActionController::ParameterMissing
    params.require(:form_entries_create_service).permit(
      field_values: [:form_field_id, :value]
    )
  end
end