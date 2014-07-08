require 'spec_helper'
require 'english'
require 'debugger'

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

ZelBug  = false
ZelBug2 = false

describe "Jem - name pkey" do

public  # === P u b l i c ===
  
  # === Name - db specs ===
  describe "- name in db" do

    it "- should catch null name (d01)" do
      aJem = Jem.new(:seq => 20)
      expect_db_error("Database did not catch null name") do
        aJem.save(:validate => false)
      end
   
   # aJem.save! - With Validations
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

  # === Name - mdl specs ===
  describe "- name in mdl" do

    it "- should catch null name (m01)" do
      aJem = Jem.new(:seq => 20)
      expect(aJem.save).to be_false
      #assert !aJem.save, "Model did not catch null name"
    end
  
    it "- should catch an empty name (m02)" do
      aJem = Jem.new(:name => '', :seq => 20)
      expect(aJem.save).to be_false
    end
  
    it "- should catch a blank name (m03)" do
      aJem = Jem.new(:name => ' ', :seq => 20)
      expect(aJem.save).to be_false
    end

    it "- should catch duplicate jem names (m04)" do
      aJem = Jem.new(:name => 'foo_bar', :seq => 20)
      aJem_dup = aJem.clone
      aJem.save
      expect(aJem_dup.save).to be_false
    end
    
    it "- should catch a name that is too long (m05)" do
      aName = 'xxxx_xxxx1xxxx_xxxx2xxxx_xxxx3xxxx_xxxx4xxxx_xxxx51'
      aJem = Jem.new(:name => aName, :seq => 20)
      expect(aJem.save).to be_false
    end

  end #describe name
  
end

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

describe "Jem - seq" do
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  describe "- seq in db" do

    it "- should allow null seq - default seq of zero (d11)" do
      aJem = Jem.new(:name => 'foo_d11')
      aJem.save(:validate => false)
      expect(aJem.seq).to eq(0)
    end

    it "- should allow default seq in Sql (d12)" do
      aJem = Jem.new(:name => 'foo_d12', :seq => :default)
        puts '=== Start d12 ===' if ZelBug
        #pending "Works with Not Null on column - without it generates unknown, unthrown error" do
        expect_db_error("Database did not allow default seq") do
          aJem.save(:validate => false)
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
  
  describe "- seq in mdl" do

   it "- should allow null seq - default seq of zero (m11)" do
      aJem = Jem.new(:name => 'foo_m11')
      expect(aJem.save).to be_true  # Allowed
      expect(aJem.seq).to eq(0)
   end

   it "- should allow default seq in sql (m12)" do
     aJem = Jem.new(:name => 'foo_m12', :seq => :default)
      expect(aJem.save).to be_false
   end

   it "- should catch negative seq (m13)" do
      aJem = Jem.new(:name => 'foo_m13', :seq => -5)
      expect(aJem.save).to be_false
   end

   it "- should catch big seq (m14)" do
      aJem = Jem.new(:name => 'foo_m14', :seq => 101)
      expect(aJem.save).to be_false
   end

   it "- should catch alpha seq (m15)" do
     aJem = Jem.new(:name => 'foo_m15', :seq => :Fred)
      expect(aJem.save).to be_false
   end

  end # describe seq

end

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

describe "Jem - comment"do

  describe "- comment in db" do

    it "- should catch a comment that is too long (d21)" do
      aCmt = 'xxxx_xxxx1xxxx_xxxx2xxxx_xxxx3xxxx_xxxx4xxxx_xxxx51'
      aJem = Jem.new(:name => 'foo_d21', :seq => 20, :comment => aCmt)
        expect_db_error("Database did not catch a comment that is too long") do
          aJem.save(:validate => false)
        end
    end

  end # describe comment

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  describe "- comment in mdl" do

   it "- should catch a comment that is too long (m21)" do
      aCmt = 'xxxx_xxxx1xxxx_xxxx2xxxx_xxxx3xxxx_xxxx4xxxx_xxxx51'
      aJem = Jem.new(:name => 'foo_m21', :seq => 20, :comment => aCmt)
      expect(aJem.save).to be_false
   end

  end # describe comment


end #Database

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
# === TimeStamps


describe "Jem - created_at" do

  describe "- in db on Insert" do

    it "- created_at should not be zero (d31)" do
      aJem = Jem.new(:name => 'd31' )
      aJem.save(:validate => false)
      expect(aJem.created_at).not_to eq(0)
    end

    it "- created_at should not be null (d32)" do
      aJem = Jem.new(:name => 'd32' )
      aJem.save(:validate => false)
      expect(aJem.created_at).not_to be_nil
    end

    it "- created_at should be within a second of current time (d33)" do
      aJem = Jem.new(:name => 'd33' )
      now_time = Time.now
      aJem.save(:validate => false)
      expect(aJem.created_at.to_i).to be_within(1).of(now_time.to_i)
    end

    it "- created_at should ignore input and use database set real time now (d34)" do
      aWrongTime = Time.xmlschema("2014-06-01T16:30:00")
      aJem = Jem.new(:name => 'd34', :created_at => aWrongTime )
      now_time = Time.now
      aJem.save(:validate => false)
      puts 'Saved created_at: ' + aJem.created_at.to_s if ZelBug
      # - - - - - - - - - - - - - - - - -
      aJem.name = 'd34'
      aJem.reload # Reload to retrieve database set value
      puts 'Reload created_at: ' + aJem.created_at.to_s if ZelBug
      expect(aJem.created_at.to_i).to be_within(1).of(now_time.to_i)
    end

  end # describe in db on Insert

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  describe "- in db on Update" do


    it "- created_at should be used for updated_at time on Insert(d41)" do
      aJem = Jem.new(:name => 'd41' )
      aJem.save(:validate => false)
      expect(aJem.created_at).to eq(aJem.updated_at)
    end


    it "created_at is not normally changed on update (d42)" 
    it "created_at can be changed on update (d43)" 
  end #
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  describe "- created_at in mdl" do

    it "- created_at in model specs (m31)"

  end # describe created_at in mdl


end #Database

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
describe "Jem - updated_at" do
  describe "- in db on Insert" do
  end
  describe "- in db on Update" do
  end
end
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

# == Schema Information
#
# Table name: jems
#
#  name       :string(50)       not null, primary key
#  seq        :integer          default(0), not null
#  comment    :string(50)       default(""), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_jems_on_seq  (seq)
#
