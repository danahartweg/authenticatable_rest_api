class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :display_name
      t.string :suffix

      t.timestamps
    end
  end
end
