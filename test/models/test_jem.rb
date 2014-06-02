require 'spec_helper'



describe Jem do

  # - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Test for Expected Database Error
  protected
  def test_for_db_error(error_message, &block)
    begin
      yield
    rescue ActiveRecord::StatementInvalid
      database_threw_error = true
    rescue
      something_else_threw_error = true
    end
    assert !something_else_threw_error, "There is an error in our test code"
    assert database_threw_error && !something_else_threw_error, error_message
  end
  # - - - - - - - - - - - - - - - - - - - - - -
  # http://enterpriserails.chak.org/full-text/
  #         chapter-5-building-a-solid-data-model
  # - - - - - - - - - - - - - - - - - - - - - -
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
public
  describe "name" do
   def test_db_no_name
      aJem = Jem.new(:seq => 20)
      test_for_db_error("Database did not catch null name") do
         aJem.save!
      end
   end

   def test_db_empty_name
      aJem = Jem.new(:name => '', :seq => 20)
      test_for_db_error("Database did not catch empty name") do
         aJem.save!
      end
   end

   def test_db_same_aJem
      aJem = Jem.new(:name => 'foo_bar', :seq => 20)
      aJem_dup = aJem.clone
      test_for_db_error("Database did not catch duplicate aJem") do
         aJem.save!
         aJem_dup.save!
      end
   end
  end
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  describe "seq" do
   def test_db_no_seq
      aJem = Jem.new(:name => 'foo_bar')
      test_for_db_error("Database did not catch null seq") do
         aJem.save!
      end
   end

   def test_db_invalid_seq
      aJem = Jem.new(:name => 'foo_bar', :seq => 'Fred')
      test_for_db_error("Database did not catch invalid seq") do
         aJem.save!
      end
   end
  end
  
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

end #Jem
# == Schema Information
#
# Table name: jems
#
#  name       :string(255)      primary key
#  seq        :integer
#  comment    :string(40)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_jems_on_seq  (seq)
#
