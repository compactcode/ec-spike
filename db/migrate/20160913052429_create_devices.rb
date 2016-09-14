class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.references :customer, foreign_key: true

      t.boolean :wants_notifications

      t.timestamps
    end
  end
end
