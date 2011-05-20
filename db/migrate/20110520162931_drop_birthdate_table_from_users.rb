class DropBirthdateTableFromUsers < ActiveRecord::Migration
  def self.up
   # remove_column(:users, :birthdate, :hash)
   # remove_column(:users, :birthday, :string)
  end

  def self.down
  end
end
