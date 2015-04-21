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
      else
        "There aren't this many options, use a smaller number."
      end
    end
  end
end
