# == Jem ==
class Jem < ActiveRecord::Base

  self.primary_key= :name

  validates_presence_of :name
  validates_uniqueness_of :name 
  
end

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
