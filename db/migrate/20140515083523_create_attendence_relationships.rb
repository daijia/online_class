class CreateAttendenceRelationships < ActiveRecord::Migration
  def change
    create_table :attendence_relationships do |t|
      t.integer :course_id
      t.integer :user_id
      t.timestamps

    end
    add_index :attendence_relationships, :course_id
    add_index :attendence_relationships, :user_id
  end
end
