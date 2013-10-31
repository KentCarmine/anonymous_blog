get '/tags/list' do
  @all_tags = Tag.all
  erb :tag_list
end

get '/tags/:id' do
  @tag = Tag.where("id = ?", params[:id]).first
  @posts = @tag.posts
  erb :display_posts_by_tag
end