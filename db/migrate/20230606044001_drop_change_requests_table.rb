class DropChangeRequestsTable < ActiveRecord::Migration[7.0]
    def up
      drop_table :change_requests
    end

    def change
      add_column :requests, :type_request, :integer, default:0
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end

end
