Formbuilder.registerField 'text',

  order: 0

  view: """
    <input type='text' class='rf-size-<%= rf.get(Formbuilder.options.mappings.SIZE) %>' />
  """

  edit: """
    <%= Formbuilder.templates['templates/formbuilder/edit/size']() %>
    <%= Formbuilder.templates['templates/formbuilder/edit/min_max_length']() %>
    <%= Formbuilder.templates['templates/formbuilder/edit/prefill']() %>
  """

  addButton: """
    <span class='symbol'><span class='fa fa-font'></span></span> Text
  """

  defaultAttributes: (attrs) ->
    attrs.field_options.size = 'small'
    attrs
