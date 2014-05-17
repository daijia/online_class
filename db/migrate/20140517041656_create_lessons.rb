class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :course_id
      t.string :name
      t.string :description, default: ""
      t.datetime :start_time
      t.integer :duration
      t.string :homework, default: ""
      t.timestamps
    end
    add_index :lessons, :course_id
  end
end
