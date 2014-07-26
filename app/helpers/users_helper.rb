module UsersHelper

  def statistic_photos(user)
    if user_signed_in? and current_user.following?(user)
      user.photos.audited.follower.count

    elsif user_signed_in? and current_user == user
      user.photos.count

    else
      user.photos.audited.published.count
    end
  end

end
