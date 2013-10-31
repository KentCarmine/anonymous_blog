class Tag < ActiveRecord::Base
  # Remember to create a migration!
  has_many :post_tags
  has_many :posts, :through => :post_tags
  validates :name, :presence => true
  validates :name, :length => { :minimum => 1 }
  validates_uniqueness_of :name
end
