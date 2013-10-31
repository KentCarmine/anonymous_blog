class Tag < ActiveRecord::Base
  # Remember to create a migration!
    has_many :post_tags
  has_many :posts :through => :post_tags
end
