class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_name, :string
    add_column :users, :website, :string
    add_column :users, :introduction, :text
    add_column :users, :phonenumber, :integer
    add_column :users, :gender, :string
  end
end
