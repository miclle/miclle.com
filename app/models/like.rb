# encoding: utf-8
class Like < ActiveRecord::Base

  belongs_to :likeable, :polymorphic => true

  belongs_to :user

  # def liked_by_user?(user)
  #   return false if user.blank?
  #   self.liked_user_ids.include?(user.id)
  # end

end
