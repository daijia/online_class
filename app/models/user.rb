class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_many :notices, class_name: "FriendRequest", foreign_key: "receiver_id", dependent: :destroy
  has_many :friend_requests, -> { where category:0 }, class_name: "FriendRequest", foreign_key: "receiver_id"
  has_many :friend_request_replies, -> { where category:1 }, class_name: "FriendRequest", foreign_key: "receiver_id"

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  has_many :courses, foreign_key: "teacher_id", dependent: :destroy
  has_many :public_courses, -> { where kind:1 }, class_name: "Course", foreign_key: "teacher_id"
  has_many :private_courses, -> { where kind:0 }, class_name: "Course", foreign_key: "teacher_id"


  has_many :course_messages, class_name: "CourseMessage", foreign_key: "receiver_id", dependent: :destroy

  has_many :attendence_relationships, dependent: :destroy
  has_many :subjects, through: :attendence_relationships, source: :course



  VALID_NAME_REGEX = /\A[^@\s]+\z/
  validates :name, presence: true, length: { minimun: 1, maximum: 50 }, format: { with: VALID_NAME_REGEX },
            uniqueness: { case_sensitive: false }
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

  def add_course_message(parameters)
    if self.course_messages.exists?(sender_id: parameters[:sender_id],
                                    course_id: parameters[:course_id],
                                    category: parameters[:category])

      self.course_messages.find_by(sender_id: parameters[:sender_id],
                                   course_id: parameters[:course_id],
                                   category: parameters[:category]).update_attributes(content: parameters[:content])
    else
      self.course_messages.create(sender_id: parameters[:sender_id],
                                  course_id: parameters[:course_id],
                                  category: parameters[:category],
                                  content: parameters[:content])
    end
  end


  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
