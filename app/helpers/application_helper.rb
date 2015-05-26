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
    case obj.class.to_s
      when "School"
        obj.main_photo.present? ? obj.main_photo.image.url(:cropped) : 'http://upload.wikimedia.org/wikipedia/commons/b/b5/Aberdeen_High_School_2.jpg'
    end
  end
end
