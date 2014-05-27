class CreateJems < ActiveRecord::Migration
  def change
    create_table :jems, 
    {:id          =>  false,
     :primary_key =>  :name
    } do |t|
    
        t.string :name, null: false
        t.integer :seq, limit: 3
        t.string :comment, limit: 40

        t.timestamps
    end
    add_index :jems, :name, unique: true
    add_index :jems, :seq
  end
  def up
     # Still not right - I added Primary Key Manually
     execute "alter table jems add primary key using (:name);"
  end
  def down
#    drop_index :jems, :seq
  end
end
