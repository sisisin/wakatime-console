class CreateExcludeRepositories < ActiveRecord::Migration[5.0]
  def change
    create_table :exclude_repositories do |t|
      t.string :names, array: true

      t.timestamps
    end
  end
end
