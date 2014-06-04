require 'spec_helper'
require 'english'

describe "Jem database" do

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  protected
  # - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Print database debug Message
  def puts_db_debug_msg(printMsg, error_handle)
    #yield
    puts printMsg
    puts error_handle.inspect
    puts error_handle.class.ancestors.inspect
  end
  
  # - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Test for Expected Database Error
  def test_for_db_error(error_message, &block)
    begin
      yield
    rescue ActiveRecord::RecordNotUnique => error_handle
      database_threw_error = true
      puts_db_debug_msg('-- database - Not Unique', error_handle)
    rescue ActiveRecord::StatementInvalid => error_handle
      database_threw_error = true
      puts_db_debug_msg('-- database error - Invalid', error_handle)
      # ActiveRecord::StatementInvalid: PG::NotNullViolation:
    rescue  => error_handle
      something_else_threw_error = true
      puts_db_debug_msg('-- === Other error ===', error_handle)
   end
    #puts errMsg
    assert !something_else_threw_error, "There is an error in our test code"
    assert database_threw_error && !something_else_threw_error, error_message
    
    # ActiveRecord::RecordInvalid: Validation failed: Name has already been taken
    # - - - - - - - - - - - - - - - - - - - - - -
    # http://enterpriserails.chak.org/full-text/
    #         chapter-5-building-a-solid-data-model
    # - - - - - - - - - - - - - - - - - - - - - -

  end
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
public
  # Name
  describe "- name" do
   it "- should catch null name (d01)" do
   puts '-- start null name'
      aJem = Jem.new(:seq => 20)
      test_for_db_error("Database did not catch null name") do
         aJem.save!
      end
   puts '-- end null name'
   end

   it "- should catch an empty name (d02)" do
      aJem = Jem.new(:name => '', :seq => 20)
      test_for_db_error("Database did not catch empty name") do
         aJem.save!
      end
   end

   it "- should catch duplicate jem names (d03)" do
      aJem = Jem.new(:name => 'foo_bar', :seq => 20)
      aJem_dup = aJem.clone
      test_for_db_error("Database did not catch duplicate aJem") do
         aJem.save!
         aJem_dup.save!
      end
   end
   it "- should catch an invalid name (d04)" do
      aJem = Jem.new(:name => 999, :seq => 20)
      test_for_db_error("Database did not catch an invalid name") do
         aJem.save!
      end
   end

  end
 

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  describe "- seq" do

   it "- should catch null seq (d05)" do
      aJem = Jem.new(:name => 'foo_bar')
      test_for_db_error("Database did not catch null seq") do
         aJem.save!
      end
   end
   
   it "- should catch invalid seq (d06)" do
   #def test_db_invalid_seq
      aJem = Jem.new(:name => 'foo_bar', :seq => 'Fred')
      test_for_db_error("Database did not catch invalid seq") do
         aJem.save!
      end
   end
   
  end
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 


=begin
   def test_db_no_length
      aJem = Jem.new(:name => 'foo_bar', :seq => 20)
      test_for_db_error("Database did not catch null aJem length") do
         aJem.save!
      end
   end

   def test_db_zero_length
      aJem = Jem.new(:name => 'foo_bar', :seq => 20,
                                 :length_minutes => '0')
      test_for_db_error("Database did not catch zero length aJem") do
         aJem.save!
      end
   end

   def test_db_negative_length
      aJem = Jem.new(:name => 'foo_bar', :seq => 20,
                                 :length_minutes => '-10')
      test_for_db_error("Database did not catch negative aJem length") do
         aJem.save!
      end
   end
=end

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
  # - - - - - - - - - - - - - - - - - - - - - -
  # - Steal from jems_controller_spec
  let(:valid_attributes) { { "name" => "rails" } }
=begin missing assigns
  describe "in creating a new Jem" do
    it "- expect to have a jem name" do
      #pending " - Jem Model rspec" do
        jem = Jem.create! valid_attributes
        assigns(:jems).should eq([jem])
      #end
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
#  seq        :integer
#  comment    :string(40)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_jems_on_seq  (seq)
#
