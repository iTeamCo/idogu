module ApplicationHelper
  def render_error(variable)
    if variable.errors.any?
      content_tag :div, :id => 'error_explanation' do
        content_tag(:h2, pluralize(variable.errors.count, 'error') << ' prohibited this user from being saved:')+
        content_tag(:ul, raw(variable.errors.full_messages.map { |msg| content_tag :li, msg }.join))
      end
    end
  end

  def submit_form(f)
    content_tag :div, :class => "actions" do
      f.submit
    end
  end
end
