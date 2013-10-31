class CreatePostTags < ActiveRecord::Migration
  def change
    create_join_table :posts, :tags, :id => false do |t|

    end
  end
end
# , :table_name => :post_tags