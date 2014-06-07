require 'spec_helper'
require 'english'
require 'debugger'

describe "Jem database" do

ZelBug = false
ZelBug2 = false

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

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
      database_threw_NotUnique = true
      prt_db_dbg_msg('-- database - Not Unique', error_handle) if ZelBug
    rescue ActiveRecord::StatementInvalid => error_handle
      database_threw_error = true    
      original_error = error_handle.original_exception
      
      if original_error.is_a? PG::NotNullViolation
        database_threw_NotNull = true
        prt_db_dbg_msg('-- database error - NotNullViolation', original_error) if ZelBug
      else        
        prt_db_dbg_msg('-- database error - Invalid', error_handle) if ZelBug
      end
      # ActiveRecord::StatementInvalid: PG::NotNullViolation:
      #  error_handle.original_exception.is_a? PG::NotNullViolation
    rescue  => error_handle
      something_else_threw_error = true
      puts error_handle
      prt_db_dbg_msg('-- === Other error ===', error_handle) if ZelBug
    # - - - - - - - - - - - - - - - - - -  
   end
   
    prt_db_dbg_flags if ZelBug
    # - - - - - - - - - - - - - - - - - -  

    assert !something_else_threw_error, "There is an error in our test code" 

    # Test that database did throw an error   
    assert database_threw_error && !something_else_threw_error, error_message
    # - - - - - - - - - - - - - - - - - - - - - -
    
    # - - - - - - - - - - - - - - - - - - - - - -
    # XRef: http://enterpriserails.chak.org/full-text/
    #         chapter-5-building-a-solid-data-model
    # - - - - - - - - - - - - - - - - - - - - - -

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
       expect_db_error("Database did not allow default seq") do
         aJem.save!
     end
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
       expect_db_error("Database did not catch alpha seq") do
         aJem.save!
     end
   end
   
  end # describe seq

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 


# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

end #Jem

# == Schema Information
#
# Table name: jems
#
#  name       :string(255)      not null, primary key
#  seq        :integer          default(0), not null
#  comment    :string(50)       default("")
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_jems_on_seq  (seq)
#
