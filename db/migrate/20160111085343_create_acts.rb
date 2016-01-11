class CreateActs < ActiveRecord::Migration
  def change
    create_table :acts do |t|
      t.string :title, null: false
      t.integer :points, default: 0, null: false
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
