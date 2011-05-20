class AddUsersTable < ActiveRecord::Migration
  def self.up
      create_table :users do |t|
        t.string :first_name
        t.string :last_name
        t.string :email
        t.string :encrypted_password
        t.string :salt
        t.string :gender
        t.text :birthdate

        t.timestamps
      end
  end

  def self.down
    drop_table :users
  end
end
