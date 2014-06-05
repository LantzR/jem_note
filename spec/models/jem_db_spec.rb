require 'spec_helper'
require 'english'
require 'debugger'

describe "Jem database" do

ZelBug = false
ZelBug2 = false

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  protected
  # - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Print database debug Message
  def prt_db_dbg_msg(printMsg, error_handle)
       puts '-- db debug msg'
       puts printMsg
       puts error_handle.inspect
       puts error_handle.class.ancestors.inspect
  end
  
  def prt_db_dbg_flags
    puts 'Flag: somethingElse: '     + something_else_threw_error.to_s
    puts 'Flag: databaseError: '     + database_threw_error.to_s
    puts 'Flag: databaseNotNull: '   + database_threw_NotNull.to_s
    puts 'Flag: databaseNotUnique: ' + database_threw_NotUnique.to_s
              
    puts 'Ending count:' + Jem.count.to_s + "\n\n"
  end
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
  public
  
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

   it "- should catch an invalid name (d05)" do
      # TODO
      pending "No test for invalid yet"
      aJem = Jem.new(:name => 999, :seq => 20)
      expect_db_error("Database did not catch an invalid name") do
         aJem.save!
      end

   end


  end
 

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  describe "- seq" do

   it "- should catch null seq (d05)" do
      aJem = Jem.new(:name => 'foo_bar')
      expect_db_error("Database did not catch null seq") do
         aJem.save!
      end
   end
   
   it "- should catch invalid seq (d06)" do
      aJem = Jem.new(:name => 'foo_too', :seq => 'Fred')
      expect_db_error("Database did not catch invalid seq") do
         aJem.save!
      end
   end
   
  end

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 


=begin
   def test_db_no_length
      aJem = Jem.new(:name => 'foo_bar', :seq => 20)
      expect_db_error("Database did not catch null aJem length") do
         aJem.save!
      end
   end

   def test_db_zero_length
      aJem = Jem.new(:name => 'foo_bar', :seq => 20,
                                 :length_minutes => '0')
      expect_db_error("Database did not catch zero length aJem") do
         aJem.save!
      end
   end

   def test_db_negative_length
      aJem = Jem.new(:name => 'foo_bar', :seq => 20,
                                 :length_minutes => '-10')
      expect_db_error("Database did not catch negative aJem length") do
         aJem.save!
      end
   end
=end

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
  # - - - - - - - - - - - - - - - - - - - - - -
  # - Steal from jems_controller_spec
  #let(:valid_attributes) { { "name" => "rails" } }
=begin missing assigns
  describe "in creating a new Jem" do
    it "- expect to have a jem name" do
        jem = Jem.create! valid_attributes
        assigns(:jems).should eq([jem])
    end
    it "- expect to have a unique jem name" do
      # " - Jem Model rspec"
    end
    it "- allow to have a only a jem name" 
  end

=end

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
