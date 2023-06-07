class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.integer :status, default: 0
      t.references :client, null: false, foreign_key: true
      t.references :isp, null: false, foreign_key: true 
      t.references :plan, null: false, foreign_key: true
      t.timestamps
    end
  end
end
