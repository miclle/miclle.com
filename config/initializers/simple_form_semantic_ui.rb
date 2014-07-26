# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|

  config.form_class = "ui form"

  config.error_notification_class = 'ui error message'

  config.button_class = 'ui button'

  config.wrappers :semantic_ui, tag: 'div', class: 'field', error_class: 'error' do |b|
    # b.use :html5
    b.use :placeholder
    b.use :label
    b.use :input
    b.use :error, wrap_with: { tag: 'div', class: 'ui red pointing above ui label' }
    # b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :semantic_ui_no_label, tag: 'div', class: 'field', error_class: 'error' do |b|
    # b.use :html5
    b.use :placeholder
    b.use :input
    b.use :error, wrap_with: { tag: 'div', class: 'ui red pointing above ui label' }
    # b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  # Semantic empowers designers and developers by creating a shared vocabulary for UI.
  # http://www.semantic-ui.com

  config.default_wrapper = :semantic_ui
end
