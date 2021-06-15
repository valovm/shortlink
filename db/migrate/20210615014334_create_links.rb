class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :url, unique: true
      t.string :code, unique: true
      t.bigint :views, default: 0

      t.timestamps
    end

    add_index :links, :url, unique: true
    add_index :links, :code, unique: true
  end
end
