class CreateFieldValues < ActiveRecord::Migration[8.0]
  def change
    create_table :field_values do |t|
      t.references :form_entry, null: false, foreign_key: true
      t.references :form_field, null: false, foreign_key: true
      t.text :value

      t.timestamps
    end

    add_index :field_values, [:form_entry_id, :form_field_id], unique: true
  end
end
