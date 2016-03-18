class CalendarEventSerializer < ActiveModel::Serializer
 attributes :id, :title, :start, :ends, :custom_class

  def start
    object.starts_at.to_datetime.strftime('%Q')
  end

  def ends
    object.ends_at.to_datetime.strftime('%Q')
  end

  def custom_class
    return 'ion-checkmark-circled text-green' if scope.attend_event?(object)
    return 'ion-minus-circled text-amber' if scope.maybe_attend_event?(object)
    return 'ion-close-circled text-danger' if scope.dont_attend_event?(object)
    'event'
  end
end