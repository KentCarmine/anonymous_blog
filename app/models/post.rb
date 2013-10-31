class Post < ActiveRecord::Base
  # Remember to create a migration!
  has_many :post_tags
  has_many :tags, :through => :post_tags
  validates :body, :presence => true
  validates :body, :length => { :minimum => 1 }
  validates :title, :presence => true
  validates :title, :length => { :minimum => 1 }

end
