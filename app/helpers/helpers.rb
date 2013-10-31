helpers do
  def create_tag_list(csv_tag_str)
    tags = csv_tag_str.split(",")
    tags = tags.map do |tag|
      tag.strip
    end

    tags.uniq!
    tags
  end

  def create_error_message(post)
    raw_message = post.errors.messages

    error_message = ""
    raw_message.each do |field, msg|
      error_message += "#{field} #{msg[0]}\n"
    end

    error_message
  end
end