# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :jem do
    name "MyString"
    seq 1
    comment "MyString"
  end
end

# == Schema Information
#
# Table name: jems
#
#  name       :string(255)      not null, primary key
#  seq        :integer          default(0), not null
#  comment    :string(50)       default(""), not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_jems_on_seq  (seq)
#
