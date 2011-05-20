class AddBirthdateToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :birthdate, :text
  end

  def self.down
    remove_column :users, :birthdate
  end
end
