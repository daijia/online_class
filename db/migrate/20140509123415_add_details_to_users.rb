class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :integer, default: 0
    add_column :users, :age, :integer, default: 0
    add_column :users, :degree, :integer, default: 0
    add_column :users, :description, :string, default: ""
  end
end
