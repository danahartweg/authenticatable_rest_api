class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string :name
      t.text :description
      t.string :web_address

      t.timestamps
    end
  end
end
