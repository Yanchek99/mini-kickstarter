class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.decimal :target_amount, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
