class CreateCourseMessages < ActiveRecord::Migration
  def change
    create_table :course_messages do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.integer :course_id
      t.integer :category
      t.string :content, default: ""

      t.timestamps
    end

    add_index :course_messages, :receiver_id
    add_index :course_messages, :sender_id

  end
end
