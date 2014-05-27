# == Jem ==
class Jem < ActiveRecord::Base
  #validates_presence_of :name
  #validates_uniqueness_of :name 
  
  # Derive name and id for display
  #def name_id
  #  "#{name} (#{id})"
  #end
  def jem_path
  end
end

# == Schema Information
#
# Table name: jems
#
#  name       :string(255)      not null
#  seq        :integer
#  comment    :string(40)
#  created_at :datetime
#  updated_at :datetime
#
