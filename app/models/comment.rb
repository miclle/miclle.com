# encoding: utf-8
class Comment < ActiveRecord::Base

  default_scope {order('created_at DESC')}

  belongs_to :entity, :polymorphic => true

  belongs_to :user

  def belong?(user)
    user_id == user.id unless user.nil?
  end

  after_create do
    # Comment.delay.send_comment_notification(self.id)
  end

  # def self.send_comment_notification(comment_id)


  # end

end
