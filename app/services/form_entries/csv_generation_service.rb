class FormEntries::CsvGenerationService < BaseService
  def initialize(form)
    @form = form
    super()
  end

  def call
    CSV.generate do |csv|
      # Header row with field name and entry numbers
      headers = ['Field']
      form_entries.each_with_index do |entry, index|
        headers << "Entry ##{index + 1}"
      end
      csv << headers

      # Data rows - each field becomes a row
      form_fields.each do |field|
        row = [field.name]
        
        # Add values for each entry
        form_entries.each do |entry|
          field_value = entry.field_values.find_by(form_field: field)
          row << (field_value&.value || '')
        end
        
        csv << row
      end
    end
  end

  def filename
    "#{@form.title.parameterize}-entries.csv"
  end

  protected

  def execute
    # This service doesn't need transaction handling, so we override call directly
    call
  end

  private

  def form_entries
    @form_entries ||= @form.form_entries.includes(:field_values, :user).order(submitted_at: :asc)
  end

  def form_fields
    @form_fields ||= @form.form_fields.order(:id)
  end
end
