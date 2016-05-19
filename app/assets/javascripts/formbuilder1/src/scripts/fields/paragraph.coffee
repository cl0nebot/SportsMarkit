Formbuilder.registerField 'paragraph',

  order: 5

  view: """
    <textarea class='rf-size-<%= rf.get(Formbuilder.options.mappings.SIZE) %>'></textarea>
  """

  edit: """
    <%= Formbuilder.templates['templates/formbuilder/edit/size']() %>
    <%= Formbuilder.templates['templates/formbuilder/edit/min_max_length']() %>
    <%= Formbuilder.templates['templates/formbuilder/edit/prefill']() %>
  """

  addButton: """
    <span class="symbol">&#182;</span> Paragraph
  """

  defaultAttributes: (attrs) ->
    attrs.field_options.size = 'small'
    attrs
