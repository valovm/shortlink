class CreateLinkStats < ActiveRecord::Migration[6.1]
  def change
    create_table :link_stats do |t|
      t.belongs_to :link, null: false
      t.string :ip_address, null: false
      t.integer :views, default: 0
      t.timestamps

    end


    add_index :link_stats, %i[link_id ip_address], unique: true
  end
end
