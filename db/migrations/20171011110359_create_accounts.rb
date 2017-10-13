Hanami::Model.migration do
  change do
    create_table :accounts do
      primary_key :id

      column :insales_subdomain,    String
      column :password,             String
      column :insales_id,           Integer
      column :delivery_id,          String
      column :store_city_id,        Integer
      column :pricing_policy,       String
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
