namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do

    ramdom = Random.new
    User.create!(name: "daijia",
                 email: "daijia@gmail.com",
                 password: "forever",
                 password_confirmation: "forever",
                 admin: true,
                 gender: 1,
                 age: 22,
                 degree: 4,
                 description: "不忘初心，方得始终")



    descriptions = ["", "奋斗者在汗水汇集的江河里，将事业之舟驶到了理想的彼岸。",
                    "忙于采集的蜜蜂，无暇在人前高谈阔论。",
                    "勇士搏出惊涛骇流而不沉沦，懦夫在风平浪静也会溺水。",
                    "志在峰巅的攀登者，不会陶醉在沿途的某个脚印之中。",
                    "海浪为劈风斩浪的航船饯行，为随波逐流的轻舟送葬。",
                    "山路不象坦途那样匍匐在人们足下.",
                    "如果圆规的两只脚都动，永远也画不出一个圆",
                    "如果你想攀登高峰，切莫把彩虹当作梯子。",
                    "脚步怎样才能不断前时？把脚印留在身后。",
                    "不管多么险峻的高山，总是为不畏艰难的人留下一条攀登的路。",
                    "让生活的句号圈住的人，是无法前时半步的。"]
    des_length = descriptions.length
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@gmail.com"
      password  = "forever"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   gender: ramdom.rand(0...2),
                   age: ramdom.rand(0...50),
                   degree: ramdom.rand(0...6),
                   description: descriptions[ramdom.rand(0...des_length)])


      #if n > 3 && n < 10
        #FriendRequest.create!(sender_id: n, receiver_id: 1, is_read: 1, content: "交个朋友吧"+n.to_s, category: 0)
      #end
    end

    Friendship.create!(user_id: 1, friend_id: 2)
    Friendship.create!(user_id: 2, friend_id: 1)
    Friendship.create!(user_id: 1, friend_id: 3)
    Friendship.create!(user_id: 3, friend_id: 1)
    Friendship.create!(user_id: 1, friend_id: 4)
    Friendship.create!(user_id: 4, friend_id: 1)

    course_categories = %w[未分组 数学 语文 英语 物理 化学 历史 政治 生物 地理 艺术 生命科学 商业和管理 计算机科学 经济和金融 教育学] +
        %w[能源和地球科学 食物和营养学 健康和社会 人文学科 信息、技术和设计 法律 医学 音乐、电影和音频 物理和地球科学 社会科学]
    course_categories.each do |name|
      CourseCategory.create!(name: name)
    end

    Course.create!(teacher_id: 1, name: "软件工程", category_id: 13, kind: 1)
    Course.create!(teacher_id: 1, name: "高一数学", category_id: 1, kind: 0)


  end

end