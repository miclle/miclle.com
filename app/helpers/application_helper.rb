# encoding: utf-8
module ApplicationHelper

  # 返回meta标签 “user令牌”标记，名称。(上传图到七牛传递user-token参数，回调时查找用户)
  def user_meta_tags
    tag('meta', :name => 'user-token', :content => current_user.uuid).html_safe if user_signed_in?
  end

  # gravatar image src
  # <%= gravatar "miclle.zheng@gmail.com", :size => 150 %>
  # => "http://gravatar.com/avatar/004794ff3508e44c4902fd82ef4027f4.png?default=monsterid&size=150"
  # default_image:  ['http://example.com/images/default_gravitar.jpg', "identicon", "monsterid", "wavatar", "404" ]
  # filetype:       ['gif', 'jpg' or 'png'].  Gravatar's default is png
  # rating:         ['G', 'PG', 'R', 'X']. Gravatar's default is G
  # size:           (1..512), default is 80
  def gravatar(email, options = {})
    configuration = {
      :default_image  =>  nil,
      :file_type      =>  "png",
      :size           =>  80
    }
    configuration.update(options) if options.is_a?(Hash)

    "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}.#{configuration[:file_type]}?default=#{configuration[:default_image]}&size=#{configuration[:size]}" unless email.blank?
  end

  def timeago_tag(datetime, options={})
    content_tag :time, nil, "data-time-ago" => datetime, :datetime => datetime, :lang => 'zh-CN', :title => datetime
  end

  # Datetime format
  # datetime_format(dateime) result: "2003-04-09 15:30"
  def datetime_format(datetime, options={})
    return nil if datetime.blank?
    configuration = { :year => true, :month => true, :day => true, :hour => true, :minute => true, :second => false }
    configuration.update(options) if options.is_a?(Hash)
    format = ""
    format << "%Y-" if configuration[:year]
    format << "%m-" if configuration[:month]
    format << "%d " if configuration[:day]
    format << "%H"  if configuration[:hour]
    format << ":%M" if configuration[:minute] and configuration[:hour]
    format << ":%S" if configuration[:second] and configuration[:minute] and configuration[:hour]
    datetime.strftime(format) unless datetime.blank?
  end

  # User follow button
  def user_follow_button(user)
    unless current_user.blank?
      if current_user == user
        # link_to "编辑个人资料", account_path, :class => "action"
      elsif current_user.following?(user)
        render "users/shared/followed", :user => user
      else
        render "users/shared/follow", :user => user
      end
    end
  end

  # Favorite button
  def favorite_button(favoriteable)
    if user_signed_in?
      render current_user.favorite?(favoriteable) ? "favorites/favorited" : "favorites/favorite", :favoriteable => favoriteable
    else
      favorites = favoriteable.favorite_users.count
      raw "<span class=\"ui mini button\"><i class=\"heart empty icon\"></i>收藏 #{favorites if favorites > 0}</span>"
    end
  end

  # Like button
  def like_button(likeable)
    if user_signed_in?
      render current_user.like?(likeable) ? "likes/liked" : "likes/like", :likeable => likeable
    else
      likes = likeable.like_users.count
      raw "<span class=\"ui mini button\"><i class=\"thumbs up outline icon\"></i>赞 #{likes if likes > 0}</span>"
    end
  end

  # semantic-ui icon helper
  def icon(*names)
    content_tag :i, nil, class: names.map{|name| "#{name.to_s.gsub('_','-')}" } << 'icon'
  end

  # Format file size
  def format_file_size(bytes)
    return if bytes.nil?
    return "#{(bytes / 1000000000)} GB" if (bytes >= 1000000000)
    return "#{(bytes / 1000000)} MB" if (bytes >= 1000000)
    return "#{(bytes / 1000)} KB"
  end

  # Google静态地图图像URL
  def google_staticmap_url(latitude, longitude, zoom, width, height)
    "http://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=#{zoom}&size=#{width}x#{height}&sensor=false&markers=color:red%7Ccolor:red%7C#{latitude},#{longitude}"
  end

end
