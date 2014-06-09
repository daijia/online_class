class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :lesson_id
      t.integer :user_id
      t.string :content

      t.timestamps
    end
  end
end
