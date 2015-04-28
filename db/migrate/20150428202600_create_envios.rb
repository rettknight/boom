class CreateEnvios < ActiveRecord::Migration
  def change
    create_table :envios do |t|
      t.string :content
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :envios, :user_id
  end
end
