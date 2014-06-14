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
    puts '-- changing seq index'
    add_index :jems, :seq

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
    reversible do |dir|
      dir.up do
        puts '-- add primary key on name'
        add_index :jems, :name, unique: true, :name => 'index_jems_on_name'
        execute "Alter Table jems Add Constraint pkey_jems Primary Key Using Index index_jems_on_name;"
        
        puts '-- add check constraints'
        execute "Alter Table jems Add Constraint jems_check_name_not_empty  Check (name <> '');"
        execute "Alter Table jems Add Constraint jems_check_name_not_blank  Check (name ~  '^\\w');"
        execute "Alter Table jems Add Constraint jems_check_name_length Check (char_length(name) <= 50);"

        execute "Alter Table jems Add Constraint jems_check_seq_0_100  Check ((seq >= 0) And (seq <= 100));"
        
        execute "Alter Table jems Add Constraint jems_check_comment_length Check (char_length(comment) <= 50);"

        sequel = <<-_End_
          Create or Replace Function crt_timestamp() Returns Trigger
          Language plpgsql
          As 
          $$
          Begin
            New.created_at = Current_Timestamp;
            New.updated_at = New.created_at;
            Return New;
          End;
          $$;
          _End_
        execute "#{sequel}"
        execute "Create Trigger jem_tgr_crt_row Before Insert On jems For Each Row Execute Procedure crt_timestamp();"
        
        sequel = <<-_End_
          Create or Replace Function upd_timestamp() Returns Trigger
          Language plpgsql
          As 
          $$
          Begin
            If (New != Old) Then
              New.updated_at = Current_Timestamp;
              Return New;
            End If;
            Return Old;
          End;
          $$;
          _End_
        execute "#{sequel}"
        execute "Create Trigger jem_tgr_upd_row Before Update On jems For Each Row Execute Procedure upd_timestamp();"
      end
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      dir.down do
        puts '-- drop primary key and check constraints'
        execute "Alter Table jems Drop Constraint If Exists pkey_jems;"
        execute "Alter Table jems Drop Constraint If Exists jems_check_name_not_empty;"
        execute "Alter Table jems Drop Constraint If Exists jems_check_name_not_blank;"
        execute "Alter Table jems Drop Constraint If Exists jems_check_name_length;"       
        execute "Alter Table jems Drop Constraint If Exists jems_check_seq_0_100;"
        execute "Alter Table jems Drop Constraint If Exists jems_check_comment_length;"       
        execute "Drop Trigger jem_tgr_upd_row on jems;"
        execute "Drop Function If Exists upd_timestamp();"
      end
    end

  end
    # - - - - - - - - - - - - - - - - - -
end
