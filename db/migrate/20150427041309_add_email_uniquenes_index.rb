class AddEmailUniquenesIndex < ActiveRecord::Migration
  def change
  	add_index :user, :email, :unique => true
  end
end
