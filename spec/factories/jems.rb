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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jem do
    name "MyString"
    seq 1
    comment "MyString"
  end
end
