# == Jem ==
class Jem < ActiveRecord::Base

  self.primary_key= :name

  validates_presence_of :name
  validates_uniqueness_of :name 
  validates_length_of :name,  maximum: 50 
  
  validates_numericality_of :seq, :only_integer => true, 
    :allow_nil => false, 
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100,
    :message => "can only be whole number between 0 and 100."
  
  validates_length_of :comment,  maximum: 50 

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
