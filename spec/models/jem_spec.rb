# == Schema Information
#
# Table name: jems
#
#  id          :integer          not null
#  name        :string(255)      not null, primary key
#  primary_key :string(255)      not null
#  seq         :integer
#  comment     :string(40)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Jem do
  pending "add some examples to (or delete) #{__FILE__}"
end
