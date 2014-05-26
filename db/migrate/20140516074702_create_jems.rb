class CreateJems < ActiveRecord::Migration
  def change
    create_table :jems, 
    {:id          =>  false
     :primary_key =>  :name
    } do |t|
    
      t.string :name, null: false
      t.integer :seq, limit: 3
      t.string :comment, limit: 40

      t.timestamps
    end
    add_index :jems, :seq
  end
  def up
#    add_index :jems, :seq
   # execute "alter table jems add primary key (id);"
  end
  def down
#    drop_index :jems, :seq
  end
end
