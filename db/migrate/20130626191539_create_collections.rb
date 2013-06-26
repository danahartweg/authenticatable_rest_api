class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description

      t.timestamps

      t.integer :domain_id
    end
  end
end
