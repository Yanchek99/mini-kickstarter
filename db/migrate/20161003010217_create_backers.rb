class CreateBackers < ActiveRecord::Migration[5.0]
  def change
    create_table :backers do |t|
      t.string :given_name, null: false
      t.references :project, index: true, foreign_key: true, null: false
      t.bigint :credit_card_number, null: false, unique: true
      t.decimal :backing_amount, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
