class CreateJems < ActiveRecord::Migration
  def change
    create_table :jems, 
    {:id          =>  false,
     :primary_key =>  :name
    } do |t|
    
        t.string :name, limit: 50, null: false
        t.integer :seq, limit: 3, default: 0, null: false
        t.string :comment, limit: 50, default: '', null: false 

        t.timestamps
        
    end
    # - - - - - - - - - - - - - - - - - -
    reversible do |dir|
      dir.up do
        puts '-- add primary key on name'
        add_index :jems, :name, unique: true, :name => 'index_jems_on_name'
        execute "Alter Table jems Add Constraint pkey_jems Primary Key Using Index index_jems_on_name;"
        
        puts '-- add check constraints'
        execute "Alter Table jems Add Constraint jems_check_name_not_empty  Check (name <> '');"
        execute "Alter Table jems Add Constraint jems_check_name_not_blank  Check (name ~  '^\\w');"

        execute "Alter Table jems Add Constraint jems_check_seq_0_100  Check ((seq >= 0) And (seq <= 100));"
        
        execute "Alter Table jems Add Constraint jems_check_name_length Check (char_length(name) <= 50);"
        execute "Alter Table jems Add Constraint jems_check_comment_length Check (char_length(comment) <= 50);"

      end
      dir.down do
        puts '-- drop primary key and check constraints'
        execute "Alter Table jems Drop Constraint If Exists pkey_jems;"
        execute "Alter Table jems Drop Constraint If Exists jems_name_check;"
        execute "Alter Table jems Drop Constraint If Exists jems_check_name_not_empty;"
        execute "Alter Table jems Drop Constraint If Exists jems_check_name_not_blank;"
        execute "Alter Table jems Drop Constraint If Exists jems_check_seq_0_100;"
        execute "Alter Table jems Drop Constraint If Exists jems_check_name_length;"       
        execute "Alter Table jems Drop Constraint If Exists jems_check_comment_length;"       
        
      end
    end
    # - - - - - - - - - - - - - - - - - -
    puts '-- changing seq index'
    add_index :jems, :seq
  end
    # - - - - - - - - - - - - - - - - - -
end
