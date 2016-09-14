class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.references :customer, foreign_key: true

      t.string  :external_id
      t.integer :balance

      t.timestamps

      t.index :external_id, unique: true
    end
  end
end
