# == Schema Information
#
# Table name: states
#
#  acronym    :string(255)
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime         not null
#

class State < ActiveRecord::Base
  attr_accessible :name, :acronym
   has_one :solution
end
