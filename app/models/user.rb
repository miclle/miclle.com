# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :async, :confirmable

  validates :username, :format => /\A\w+\z/, :length => {:in => 3..20}, :presence => true, :uniqueness => {:case_sensitive => false}

  validates :username, :exclusion => Settings.username_exclusion

  attr_accessor :login

  GENDER = [:female, :male]

  default_scope { order('created_at DESC') }

  mount_uploader :avatar, AvatarUploader

  has_many :photos, :dependent => :destroy

  has_many :albums, :dependent => :destroy

  has_many :comments, :dependent => :destroy

  # 关注
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :followed_users, :through => :relationships, :source => :followed

  # 粉丝
  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower

  # Favorites
  has_many :favorites, :dependent => :destroy
  has_many :photo_favorites, -> { where :favoriteable_type => "Photo" }, class_name: 'Favorite', :dependent => :destroy

  has_many :favorite_photos, :through => :photo_favorites, :source => :favoriteable, :source_type => 'Photo'

  # Likes
  has_many :likes, :dependent => :destroy
  has_many :photo_likes, -> { where :likeable_type => "Photo" }, class_name: 'Like', :dependent => :destroy

  before_create :set_uuid

  def admin?
    'admin' == role
  end

  # Overwrite default name get method
  def nickname
    attributes['name'].blank? ? attributes['username'] : attributes['name']
  end

  # Follow functions
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(:followed_id => other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  # Favorite functions
  def favoriteable(favoriteable_type)
    favorites.where(:favoriteable_type => favoriteable_type)
  end

  def favorite?(favoriteable)
    favorites.find_by_favoriteable_type_and_favoriteable_id(favoriteable.class, favoriteable.id)
  end

  # Like functions
  def likeable(likeable_type)
    likes.where(:likeable_type => likeable_type)
  end

  def like?(likeable)
    likes.find_by_likeable_type_and_likeable_id(likeable.class, likeable.id)
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # User.find(1).confirm!      # returns true unless it's already confirmed
  # User.find(1).confirmed?    # true/false
  # User.find(1).send_confirmation_instructions # manually send instructions

  private

    def set_uuid
      self.uuid ||= SecureRandom.uuid.gsub("-","")
    end

end
