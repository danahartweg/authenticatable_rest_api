class CreateSwatches < ActiveRecord::Migration
  def change
    create_table :swatches do |t|
      t.string :name
      t.text :description
      t.string :thumb_link
      t.string :img_link

      t.timestamps

      t.integer :collection_id
			t.integer :manufacturer_id
    end
  end
end
