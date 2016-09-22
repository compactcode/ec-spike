class AddPhoneNumberToDevices < ActiveRecord::Migration[5.0]
  def change
    change_table :devices do |t|
      t.string :phone_number

      t.index :phone_number, unique: true
    end
  end
end
