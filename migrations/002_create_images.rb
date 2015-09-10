Sequel.migration do
  up do
    create_table(:images) do
      primary_key :id

      String :name
      String :url
      String :tag
      String :caption


    end
  end

  down do
    drop_table(:images)
  end
end