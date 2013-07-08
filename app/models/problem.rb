# == Schema Information
#
# Table name: problems
#
#  active              :boolean
#  body_content_type   :string(255)
#  body_file_name      :string(255)
#  body_file_size      :integer
#  body_updated_at     :datetime
#  created_at          :datetime         not null
#  id                  :integer          not null, primary key
#  input_content_type  :string(255)
#  input_file_name     :string(255)
#  input_file_size     :integer
#  input_updated_at    :datetime
#  output_content_type :string(255)
#  output_file_name    :string(255)
#  output_file_size    :integer
#  output_updated_at   :datetime
#  time                :integer
#  title               :string(255)
#  updated_at          :datetime         not null
#

class Problem < ActiveRecord::Base
  attr_accessible :body, :input, :output, :time, :title, :active, :judgeSolution, :size
  has_many :solutions
  has_and_belongs_to_many :contests
  has_attached_file :input
  has_attached_file :output
  has_attached_file :body
  has_attached_file :judgeSolution

   scope :active, where("active = true")

  validates_presence_of :body, :input, :output, :time, :title
  validates_uniqueness_of :title, :scope => [:active] if active == true
  

 

  

end



