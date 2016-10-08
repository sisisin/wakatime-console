class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.date :date, null: false
      t.string :name, null: false
      t.integer :total_seconds, null: false

      t.timestamps
    end
    add_index :projects, [:date, :name], unique: true
  end
end
