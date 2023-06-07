class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :password
      t.string :token
      
      t.timestamps
    end
  end
end