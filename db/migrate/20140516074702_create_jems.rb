class CreateJems < ActiveRecord::Migration
  def change
    create_table :jems do |t|
      t.string :name, null: false
      t.integer :seq, limit: 3
      t.string :comment, limit: 40

      t.timestamps
    end
    add_index :jems, :name, unique: true
    add_index :jems, :seq
  end
end
