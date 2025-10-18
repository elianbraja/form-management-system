class CreateFormFields < ActiveRecord::Migration[8.0]
  def change
    create_table :form_fields do |t|
      t.references :form, null: false, foreign_key: true
      t.string :name, null: false
      t.string :field_type, null: false
      t.jsonb :validations, null: false, default: {}
      t.boolean :required, null: false, default: true

      t.timestamps
    end

    add_index :form_fields, [:form_id, :name]
  end
end
