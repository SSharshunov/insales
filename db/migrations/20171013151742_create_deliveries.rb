Hanami::Model.migration do
  change do
    create_table :deliveries do
      primary_key :id

      column :insales_id,           Integer
      column :delivery_id,          Integer

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
