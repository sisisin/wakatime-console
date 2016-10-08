class CreateOperatingSystems < ActiveRecord::Migration[5.0]
  def change
    create_table :operating_systems do |t|
      t.references :project, foreign_key: true, null: false
      t.string :name, null: false
      t.integer :total_seconds, null: false

      t.timestamps
    end
  end
end
