class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.text :name
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :words, [:name, :created_at]
  end
end
