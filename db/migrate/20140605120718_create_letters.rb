class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.string :content, default: ""
      t.boolean :is_read, default: false

      t.timestamps
    end
  end
end
