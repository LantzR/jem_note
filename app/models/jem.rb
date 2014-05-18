# == Schema Information
#
# Table name: jems
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  seq        :integer
#  comment    :string(40)
#  created_at :datetime
#  updated_at :datetime
#

class Jem < ActiveRecord::Base
  validates_presence_of :name
  
  # Derive name and id for display
  def name_id
    "#{name} (#{id})"
  end
end
