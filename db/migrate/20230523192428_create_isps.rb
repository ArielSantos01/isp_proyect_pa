class CreateIsps < ActiveRecord::Migration[7.0]
  def change
    create_table :isps do |t|
      t.string :name
      t.string :username
      t.string :password
      t.string :token

      t.timestamps
    end
  end
end
