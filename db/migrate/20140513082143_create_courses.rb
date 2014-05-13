class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :teacher_id
      t.string :name
      t.integer :status, default: 0
      t.integer :category_id, default: 0
      t.integer :kind, default: 0
      t.string :description, default: ""
      t.string :reference, default: ""
      t.string :plan, default: ""
      t.string :knowledge, default: ""

      t.timestamps
    end

    add_index :courses, :teacher_id

  end
end
