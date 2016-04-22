class FormBuilder::SectionBreak < FormBuilder::Base
  def render
    content_tag :h4, @data["label"], class: "bold"
  end
end