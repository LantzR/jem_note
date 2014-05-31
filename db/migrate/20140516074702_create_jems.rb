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
    # - - - - - - - - - - - - - - - - - -
    reversible do |dir|
      dir.up do
        puts '-- add primary key on name'
        add_index :jems, :name, unique: true, :name => 'index_jems_on_name'
        execute "Alter Table jems Add constraint pkey_jems Primary Key Using Index index_jems_on_name;"
        # - Note - Can _Not_ put index name in quotes
      end
      dir.down do
        puts '-- drop primary key'
        execute "Alter Table jems Drop Constraint If Exists pkey_jems"
      end
    end
    # - - - - - - - - - - - - - - - - - -
    puts '-- changing seq index'
    add_index :jems, :seq
  end
    # - - - - - - - - - - - - - - - - - -
end
