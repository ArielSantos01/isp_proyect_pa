class DropChangeRequestsTablev2 < ActiveRecord::Migration[7.0]
  def up
    drop_table :change_requests
  end
end
