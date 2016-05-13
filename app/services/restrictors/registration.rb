class Restrictors::Registration
  include Interactor

  delegate :form, to: :context

  def call
    check_for_options
    check_for_activity
  end

  def check_for_options
    context.fail! if !context.form.try(:options).present? && context.preview.blank? rescue false
    if context.launch
      context.error = 'Please add payment options'
    else
      context.error = 'No payment options available yet'
    end
  end

  def check_for_activity
    context.fail!(error: "Registration will start #{start_date}") if Date.today < start_date && context.preview.blank? rescue false
    context.fail!(error: "Registration already finished on #{end_date}") if Date.today > end_date && context.preview.blank? rescue false
  end

  def start_date
    form.start_date.present? ? form.start_date : Date.yesterday
  end

  def end_date
    form.end_date.present? ? form.end_date : Date.tomorrow
  end
end