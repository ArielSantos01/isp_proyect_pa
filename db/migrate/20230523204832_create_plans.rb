class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :speed
      t.float :price 
      t.references :isp, null: false, foreign_key: true
      

      t.timestamps
    end
  end
end
