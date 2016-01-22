class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.belongs_to :act, index: true
      t.date :date

      t.timestamps null: false
    end
  end
end
