get '/posts/list' do
  @all_posts = Post.all
  erb :all_posts
end

get '/posts/new' do
  erb :new_post
end

post '/posts/new' do

  # Create a new post object and save it to DB

  # LOOP through each tag
  #   Attempt to create the tag
  #   Search through DB and retrieve the tag
  #   Push the tags into the post with:    post.tags << tag
  #   Save the post
  #END LOOP

  post_title = params[:title]

  post_tags_csv = params[:tags]
  post_tags = create_tag_list(post_tags_csv)

  post_text = params[:post_text]
  post = Post.create(:title => post_title, :body => post_text)

  if post.invalid?
    @error_message = create_error_message(post)
    redirect to "/posts/error/#{@error_message}"
  else

    post_tags.each do |tag_name|
      tag = Tag.new(:name => tag_name)
      tag.save

      tag = Tag.where("name = ?", tag_name).first
      post.tags << tag
      post.save
    end

    redirect to '/'
  end
end

get '/posts/:id' do
  @post = Post.where("id = ?", params[:id]).first

  @tag_names = @post.tags.map do |tag|
    tag.name
  end

  @tag_names = @tag_names.join(", ")

  erb :display_post
end

get '/posts/error/:error_message' do
  @error_message = params[:error_message]
  erb :post_error
end

post '/posts/delete/:id' do
  Post.delete(params[:id])
  redirect to '/posts/list'
end

get '/posts/edit/:id' do
  @post = Post.where("id = ?", params[:id]).first

  @tag_names = @post.tags.map do |tag|
    tag.name
  end

  @tag_names = @tag_names.join(", ")


  erb :edit_post
end

post '/posts/edit/:id' do

  @post = Post.where("id = ?", params[:id]).first

  @tag_names = @post.tags.map do |tag|
    tag.name
  end

  @tag_names = @tag_names.join(", ")

  @post.title = params[:title]
  @post.body = params[:post_text]
  @post.save

  post_tags_csv = params[:tags]
  post_tags = create_tag_list(post_tags_csv)

  if @post.invalid?
    @error_message = create_error_message(post)
    redirect to "/posts/error/#{@error_message}"
  else
    @post.tags.clear

    post_tags.each do |tag_name|
      tag = Tag.new(:name => tag_name)
      tag.save

      tag = Tag.where("name = ?", tag_name).first
      @post.tags << tag
      @post.save
    end

    redirect to '/'
  end

   redirect to '/posts/list'
end

# def create_tag_list(csv_tag_str)
#   tags = csv_tag_str.split(",")
#   tags = tags.map do |tag|
#     tag.strip
#   end

#   tags.uniq!
#   tags
# end

# def create_error_message(post)
#   raw_message = post.errors.messages

#   error_message = ""
#   raw_message.each do |field, msg|
#     error_message += "#{field} #{msg[0]}\n"
#   end

#   error_message
# end