require 'spec_helper'
require 'english'
require 'debugger'


# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 


describe "Jem database" do

ZelBug = false
ZelBug2 = false
 
protected  # === P r o t e c t e d ===

  # - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Test for Expected Database Error
  def expect_db_error(error_message, &block)
  
    begin
      puts 'Starting count: ' + Jem.count.to_s if ZelBug2
      yield
    # - - - - - - - - - - - - - - - - - -  
    rescue ActiveRecord::RecordNotUnique => error_handle
      database_threw_error = true
      something_else_threw_error = false
      database_threw_NotUnique = true
      prt_db_dbg_msg('-- database - Not Unique', error_handle) if ZelBug
=begin - Wishful thinking  
    rescue ActiveRecord::CheckViolation => error_handle
      database_threw_error = true
      something_else_threw_error = false
      database_threw_Check = true
      prt_db_dbg_msg('-- database - CheckViolation', error_handle) if ZelBug  
=end
    rescue ActiveRecord::StatementInvalid => error_handle
      database_threw_error = true
      something_else_threw_error = false
      debugger  if ZelBug2
      original_error = error_handle.original_exception

      if original_error.is_a? PG::NotNullViolation
        database_threw_NotNull = true
        prt_db_dbg_msg('-- database error - NotNullViolation', original_error) if ZelBug
      elsif original_error.is_a? PG::CheckViolation
        database_threw_Check = true
        prt_db_dbg_msg('-- database error - CheckViolation', original_error) if ZelBug
      else        
        something_else_threw_error = true
        prt_db_dbg_msg('-- database error - Invalid', error_handle) if ZelBug
      end
      # ActiveRecord::StatementInvalid: PG::NotNullViolation:
      #  error_handle.original_exception.is_a? PG::NotNullViolation
    rescue  => error_handle
      something_else_threw_error = true
      puts error_handle
      prt_db_dbg_msg('-- === Other error ===', error_handle) if ZelBug
    # - - - - - - - - - - - - - - - - - - 
    ensure
      # Yulch
      if !something_else_threw_error && !database_threw_error
        something_else_threw_error = true
        database_Unknown_Unthrown_Error = true
        debugger if ZelBug2
        prt_db_dbg_msg('-- === Unknown Unthrown error ===', error_handle) if ZelBug
        # Issue with d12 & d15 and null allowed
      end  
   end
   
       if ZelBug
         puts 'Flag: somethingElse: '     + something_else_threw_error.to_s
         puts 'Flag: UnknownUnthrown: '   + database_Unknown_Unthrown_Error.to_s

         puts 'Flag: databaseError: '     + database_threw_error.to_s
         puts 'Flag: databaseNotNull: '   + database_threw_NotNull.to_s
         puts 'Flag: databaseNotUnique: ' + database_threw_NotUnique.to_s
         puts 'Flag: databaseCheck: '     + database_threw_Check.to_s
             
         puts 'Ending count:' + Jem.count.to_s + "\n\n" if ZelBug2
       end #ZelBug

    # - - - - - - - - - - - - - - - - - -  
    # Assertions for Database Spec
    assert !something_else_threw_error, "There is an error in our test code" 

    # Unknown and Unthrown error
    assert !database_Unknown_Unthrown_Error, "There is an Unknown and Unthrown error in our test code" 
    
    # Test that database did throw an error   
    assert database_threw_error && !something_else_threw_error, error_message
    
    # - - - - - - - - - - - - - - - - - - - - - -
    
    # - - - - - - - - - - - - - - - - - - - - - -
    # XRef: http://enterpriserails.chak.org/full-text/
    #         chapter-5-building-a-solid-data-model
    # - - - - - - - - - - - - - - - - - - - - - -
  end
  
    # - - - - - - - - - - - - - - - - - - - - - - - - - - -
    # Print Database Debug Messages
  def prt_db_dbg_msg(printMsg, error_handle)
    puts '-- db debug msg'
    puts printMsg
    puts error_handle.inspect
    puts error_handle.class.ancestors.inspect
  end
  

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

public  # === P u b l i c ===
  
  # === Name ===
  describe "- name" do

   it "- should catch null name (d01)" do
      aJem = Jem.new(:seq => 20)
      expect_db_error("Database did not catch null name") do
         aJem.save!
      end
   
   #  error_handle.original_exception.kind_of? PG::NotNullViolation
   # ActiveRecord::StatementInvalid
   end
   
   it "- should catch an empty name (d02)" do
      aJem = Jem.new(:name => '', :seq => 20)
      expect_db_error("Database did not catch empty name") do
         aJem.save!
      end
      
      # Note - 
   end

   it "- should catch an blank name (d03)" do
      aJem = Jem.new(:name => ' ', :seq => 20)
      expect_db_error("Database did not catch blank name") do
         aJem.save! 
      end
   end

   it "- should catch duplicate jem names (d04)" do
      aJem = Jem.new(:name => 'foo_bar', :seq => 20)
      aJem_dup = aJem.clone
      expect_db_error("Database did not catch duplicate aJem") do
         aJem.save!
         aJem_dup.save!
      end
   end

  end #describe name

 
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  describe "- seq" do

   it "- should allow null seq - default seq of zero (d11)" do
      aJem = Jem.new(:name => 'foo_d11')
      aJem.save!
      expect(aJem.seq).to eq(0)
   end

   it "- should allow default seq (d12)" do
     aJem = Jem.new(:name => 'foo_d12', :seq => :default)
       puts '=== Start d12 ===' if ZelBug
       #pending "Works with Not Null on column - without it generates unknown, unthrown error" do
       expect_db_error("Database did not allow default seq") do
         aJem.save!
       #end
     end
       puts '=== End d12 ===' if ZelBug
   end

   it "- should catch negative seq (d13)" do
      aJem = Jem.new(:name => 'foo_d13', :seq => -5)
      expect_db_error("Database did not catch negative seq") do
         aJem.save!
      end
   end

   it "- should catch big seq (d14)" do
      aJem = Jem.new(:name => 'foo_d14', :seq => 101)
      expect_db_error("Database did not catch seq greater than 100") do
         aJem.save!
      end
   end

   it "- should catch alpha seq (d15)" do
     aJem = Jem.new(:name => 'foo_d15', :seq => :Fred)
       puts '=== Start d15 ===' if ZelBug
       #pending "Works with Not Null on column - without it generates NilClass, unthrown error" do
       expect_db_error("Database did not catch alpha seq") do
         aJem.save!
       #end  
     end
       puts '=== End d15 ===' if ZelBug
       # NilClass, JSON::Ext::Generator::GeneratorMethods::NilClass
   end

  end # describe seq

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 


# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

end #Jem
