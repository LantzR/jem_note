require 'spec_helper'
require 'english'
require 'debugger'

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 


describe "Jem database" do

ZelBug = false
ZelBug2 = false

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

public  # === P u b l i c ===
  
  # === Name ===
  describe "- name" do

   it "- should catch null name (d01)" do
      aJem = Jem.new(:seq => 20)
      expect_db_error("Database did not catch null name") do
         aJem.save(:validate => false)
      end
   
         #aJem.save! - With Validations
   #  error_handle.original_exception.kind_of? PG::NotNullViolation
   # ActiveRecord::StatementInvalid
   end
   
   it "- should catch an empty name (d02)" do
      aJem = Jem.new(:name => '', :seq => 20)
      expect_db_error("Database did not catch empty name") do
         aJem.save(:validate => false)
      end
      
      # Note - 
   end

   it "- should catch a blank name (d03)" do
      aJem = Jem.new(:name => ' ', :seq => 20)
      expect_db_error("Database did not catch a blank name") do
         aJem.save(:validate => false)
      end
   end

   it "- should catch duplicate jem names (d04)" do
      aJem = Jem.new(:name => 'foo_bar', :seq => 20)
      aJem_dup = aJem.clone
      expect_db_error("Database did not catch duplicate aJem") do
         aJem.save
         aJem_dup.save(:validate => false)
      end
   end

   it "- should catch a name that is too long (d05)" do
      aName = 'xxxx_xxxx1xxxx_xxxx2xxxx_xxxx3xxxx_xxxx4xxxx_xxxx51'
      aJem = Jem.new(:name => aName, :seq => 20)
        expect_db_error("Database did not catch a name that is too long") do
          aJem.save(:validate => false)
      end
   end

  end #describe name

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  describe "- seq" do

   it "- should allow null seq - default seq of zero (d11)" do
      aJem = Jem.new(:name => 'foo_d11')
      aJem.save(:validate => false)
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
         aJem.save(:validate => false)
      end
   end

   it "- should catch big seq (d14)" do
      aJem = Jem.new(:name => 'foo_d14', :seq => 101)
      expect_db_error("Database did not catch seq greater than 100") do
         aJem.save(:validate => false)
      end
   end

   it "- should catch alpha seq (d15)" do
     aJem = Jem.new(:name => 'foo_d15', :seq => :Fred)
       puts '=== Start d15 ===' if ZelBug
       #pending "Works with Not Null on column - without it generates NilClass, unthrown error" do
       expect_db_error("Database did not catch alpha seq") do
         aJem.save(:validate => false)
       #end  
     end
       puts '=== End d15 ===' if ZelBug
       # NilClass, JSON::Ext::Generator::GeneratorMethods::NilClass
   end

  end # describe seq

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  describe "- comment" do

   it "- should catch a comment that is too long (d21)" do
      aCmt = 'xxxx_xxxx1xxxx_xxxx2xxxx_xxxx3xxxx_xxxx4xxxx_xxxx51'
      aJem = Jem.new(:name => 'foo_d21', :seq => 20, :comment => aCmt)
        expect_db_error("Database did not catch a comment that is too long") do
          aJem.save(:validate => false)
      end
   end

  end # describe comment

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

describe "Jem model" do


# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

public  # === P u b l i c ===
  
  # === Name ===
  describe "- name" do

   it "- should catch null name (m01)" do
      aJem = Jem.new(:seq => 20)
      expect(aJem.save).to be_false
      #assert !aJem.save, "Model did not catch null name"
   end

  end
  
=begin
=-=-=-=-=-=-=-=-=-=-=-=-=-=
  
     it "- should catch an empty name (m02)" do
      aJem = Jem.new(:name => '', :seq => 20)
      expect_mb_error("Model did not catch empty name") do
         aJem.save!
      end
      
      # Note - 
   end

   it "- should catch a blank name (m03)" do
      aJem = Jem.new(:name => ' ', :seq => 20)
      expect_mb_error("Model did not catch a blank name") do
         aJem.save! 
      end
   end

   it "- should catch duplicate jem names (m04)" do
      aJem = Jem.new(:name => 'foo_bar', :seq => 20)
      aJem_mup = aJem.clone
      expect_mb_error("Model did not catch duplicate aJem") do
         aJem.save!
         aJem_mup.save!
      end
   end

   it "- should catch a name that is too long (m05)" do
      aName = 'xxxx_xxxx1xxxx_xxxx2xxxx_xxxx3xxxx_xxxx4xxxx_xxxx51'
      aJem = Jem.new(:name => aName, :seq => 20)
        expect_mb_error("Model did not catch a name that is too long") do
          aJem.save!
      end
   end

  end #describe name

 
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  describe "- seq" do

   it "- should allow null seq - default seq of zero (m11)" do
      aJem = Jem.new(:name => 'foo_m11')
      aJem.save!
      expect(aJem.seq).to eq(0)
   end

   it "- should allow default seq (m12)" do
     aJem = Jem.new(:name => 'foo_m12', :seq => :default)
       puts '=== Start d12 ===' if ZelBug
       #pending "Works with Not Null on column - without it generates unknown, unthrown error" do
       expect_mb_error("Model did not allow default seq") do
         aJem.save!
       #end
     end
       puts '=== End d12 ===' if ZelBug
   end

   it "- should catch negative seq (m13)" do
      aJem = Jem.new(:name => 'foo_m13', :seq => -5)
      expect_mb_error("Model did not catch negative seq") do
         aJem.save!
      end
   end

   it "- should catch big seq (m14)" do
      aJem = Jem.new(:name => 'foo_m14', :seq => 101)
      expect_mb_error("Model did not catch seq greater than 100") do
         aJem.save!
      end
   end

   it "- should catch alpha seq (m15)" do
     aJem = Jem.new(:name => 'foo_m15', :seq => :Fred)
       puts '=== Start d15 ===' if ZelBug
       #pending "Works with Not Null on column - without it generates NilClass, unthrown error" do
       expect_mb_error("Model did not catch alpha seq") do
         aJem.save!
       #end  
     end
       puts '=== End d15 ===' if ZelBug
       # NilClass, JSON::Ext::Generator::GeneratorMethods::NilClass
   end

  end # describe seq

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  describe "- comment" do

   it "- should catch a comment that is too long (m21)" do
      aCmt = 'xxxx_xxxx1xxxx_xxxx2xxxx_xxxx3xxxx_xxxx4xxxx_xxxx51'
      aJem = Jem.new(:name => 'foo_m21', :seq => 20, :comment => aCmt)
        expect_mb_error("Model did not catch a comment that is too long") do
          aJem.save!
      end
   end

  end # describe comment
  
=-=-=-=-=-=-=-=-=-=
=end

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 


# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

end #Jem

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 


# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

end #Jem
