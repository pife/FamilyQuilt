class AddFirstNameAndLastNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    
    remove_column(:users, :name)
  end

  def self.down
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
