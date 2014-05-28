# == Jem ==
class Jem < ActiveRecord::Base

  self.primary_key= :name

  #validates_presence_of :name
  validates_uniqueness_of :name 
  
end

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
