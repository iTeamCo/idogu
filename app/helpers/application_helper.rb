module ApplicationHelper
  def render_error(instance)
    if instance.errors.any?
      content_tag :div, :id => 'error_explanation' do
        content_tag(:h2, pluralize(instance.errors.count, 'error') << ' prohibited this user from being saved:')+
        content_tag(:ul, raw(instance.errors.full_messages.map { |msg| content_tag :li, msg }.join))
      end
    end
  end

  def submit_form(f)
    content_tag :div, :class => "actions" do
      f.submit
    end
  end

  def tag_helper(f, type, field)
    content_tag :div, :class => "field" do
      f.label(field)  <<
      raw('<br />')   <<
      f.send(type, field)
    end
  end

  def action_list(instance, edit_path)
    content_tag(:td) { link_to 'Show', instance }   <<
    content_tag(:td) { link_to 'Edit', edit_path }  <<
    content_tag(:td) { link_to 'Destroy', instance, confirm: 'Are you sure?', method: :delete }
  end

  def render_form(instance, opts={})
    form_for instance, :html => opts[:html] do |f|
      raw(render_error instance) <<
      raw(opts[:fields].map{|k,v| tag_helper f, v, k }.join) <<
      submit_form(f)
    end
  end

end
