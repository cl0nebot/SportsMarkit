module ApplicationHelper
  
  def format(object, option)
    if [ActiveSupport::TimeWithZone, Date, DateTime].include? object.class
      case option
      when 1
        "#{object.month}/#{object.day}/#{object.year}"
      when 2
        "#{object.month}-#{object.day}-#{object.year}"
      when 3
        "#{object.strftime("%b")} #{object.day}, #{object.year}"
      when 4
        "#{object.strftime("%B")} #{object.day}, #{object.year}"
      when 5
        "#{object.strftime("%B")} #{object.day.ordinalize}, #{object.year}"
      when 6
        "#{object.strftime("%B")} #{object.day.ordinalize}"
      when 7
        "#{object.strftime("%-H:%M")}"
      when 8
        "#{object.strftime("%l:%M")}"
      when 9
        "#{object.strftime("%B")}"
      when 10
        "#{object.day}"
      when 11
        "#{object.year}"
      when 12
        "There aren't this many options, use a smaller number."
      end
    end
  end

  def creator_name(user)
    user == current_user ? "Me" : user.full_name
  end

  def background_url(obj)
    urls = {"School" => 'http://upload.wikimedia.org/wikipedia/commons/b/b5/Aberdeen_High_School_2.jpg',
     'User' => image_path("thumbs/football-game.jpg"),
     'Team' => 'http://svite-league-apps-content.s3.amazonaws.com/bgimages/sports-wave.jpg',
     'Facility' => 'http://despacedesigns.com/wp-content/uploads/2013/11/blog_YMCA_AB_2L3V9636.jpg'}
    (obj.main_photo.try(:persisted?) && obj.main_photo.image.url.present?) ? obj.main_photo.image.url : urls[obj.class.to_s]
  end
end
