class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_many :friend_requests, -> { where category:0 }, class_name: "FriendRequest", foreign_key: "receiver_id"
  has_many :friend_request_replies, -> { where category:1 }, class_name: "FriendRequest", foreign_key: "receiver_id"
  has_many :notices, class_name: "FriendRequest", foreign_key: "receiver_id", dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  has_many :courses, foreign_key: "teacher_id", dependent: :destroy
  has_many :public_courses, -> { where kind:1 }, class_name: "Course", foreign_key: "teacher_id"
  has_many :private_courses, -> { where kind:0 }, class_name: "Course", foreign_key: "teacher_id"



  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :gender, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2}
  validates :degree, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 6}
  validates :age, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  validates :description, length: { maximum: 200}

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def be_friend_with(other_user)
    if other_user.id == self.id
      return false
    end
    unless self.friendships.exists?(friend_id: other_user.id)
      self.friendships.create(friend_id: other_user.id)
    end
    unless other_user.friendships.exists?(friend_id: self.id)
      other_user.friendships.create(friend_id: self.id)
    end
  end

  def not_be_friend_with(other_user)
    self.friendships.find_by(friend_id: other_user.id).destroy
    other_user.friendships.find_by(friend_id: self.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
