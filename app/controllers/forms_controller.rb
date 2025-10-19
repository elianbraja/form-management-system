class FormsController < ApplicationController
  # Skip authentication for index action (shows welcome page for non-authenticated users)
  skip_before_action :authenticate_user!, only: [:index]
  
  before_action :set_form, only: [:show, :edit, :update, :destroy]
  before_action :authorize_form_access, only: [:show, :edit, :update, :destroy]
  before_action :check_form_editable, only: [:edit, :update]

  def index
    @forms = policy_scope(Form).order(created_at: :desc) if user_signed_in?
  end

  def show
  end

  def new
    @form_service = Forms::CreateService.new(user_id: current_user.id)
  end

  def create
    @form_service = Forms::CreateService.new(form_service_params)
    
    if @form_service.call
      redirect_to @form_service.form, notice: 'Form was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @form_service = Forms::UpdateService.new(@form, title: @form.title)
  end

  def update
    @form_service = Forms::UpdateService.new(@form, form_update_service_params)
    
    if @form_service.call
      redirect_to @form, notice: 'Form was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @form.destroy
    redirect_to forms_url, notice: 'Form was successfully deleted.'
  end

  private

  def set_form
    @form = policy_scope(Form).find(params[:id])
  end

  def authorize_form_access
    authorize @form
  end

  def check_form_editable
    return if @form.editable?
    
    redirect_to @form, alert: 'This form cannot be edited because it has existing entries. To maintain data consistency, forms with entries are locked from editing.'
  end

  def form_service_params
    params.require(:forms_create_service).permit(
      :title, 
      :user_id, 
      fields: [:name, :field_type, :required, :min_length, :max_length, :min_value, :max_value]
    )
  end

  def form_update_service_params
    params.require(:forms_update_service).permit(
      :title, 
      fields: [:name, :field_type, :required, :min_length, :max_length, :min_value, :max_value]
    )
  end
end
