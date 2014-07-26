# encoding: utf-8
class Favorite < ActiveRecord::Base

  belongs_to :favoriteable, :polymorphic => true

  belongs_to :user

end
