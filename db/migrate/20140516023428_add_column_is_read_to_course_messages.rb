class AddColumnIsReadToCourseMessages < ActiveRecord::Migration
  def change
    add_column :course_messages, :is_read, :integer, default: 0
  end
end
