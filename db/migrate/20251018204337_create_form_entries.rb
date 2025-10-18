class CreateFormEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :form_entries do |t|
      t.references :form, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :submitted_at, null: false

      t.timestamps
    end

    add_index :form_entries, [:form_id, :submitted_at]
  end
end
