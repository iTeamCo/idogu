module ApplicationHelper

  def render_error(instance)
    if instance.errors.any?
      content_tag :div, id: 'error_explanation' do
        content_tag(:h2, pluralize(instance.errors.count, 'error') << ' prohibited this user from being saved:')+
            content_tag(:ul, raw(instance.errors.full_messages.map { |msg| content_tag :li, msg }.join))
      end
    end
  end

  def submit_form(f)
    content_tag(:div, class: 'actions') { f.submit }
  end

  def tag_helper(f, type, field, setting=nil)
    content_tag :div, class: 'field' do
      f.label(field) <<
          raw('<br />') <<
          setting.nil? ? f.send(type, field) : f.send(type, field, setting)
    end
  end

  def render_form(instance, opts={ })
    opts[:setting] ||= { }
    form_for instance, html: opts[:html] do |f|
      raw(render_error instance) <<
          raw(opts[:fields].map { |k, v| tag_helper f, v, k, opts[:setting][:k] }.join) <<
          submit_form(f)
    end
  end

  def render_notice
    content_tag(:p, id: 'notice') { notice }
  end

  def render_header(header_for=nil)
    header_for = ": #{header_for}" unless header_for.nil?
    content_tag(:h1) { "#{action_name.humanize} #{controller_name.humanize.singularize}#{header_for}" }
  end

  def action_links(instance)
    content_tag(:td) { show_link instance } <<
        content_tag(:td) { edit_link instance } <<
        content_tag(:td) { destroy_link instance }
  end

  def new_link
    link_to "New #{controller_name.humanize.singularize}",
            send("new_#{controller_name.singularize}_path")
  end

  def destroy_link(instance)
    link_to 'Destroy',
            instance,
            confirm: 'Are you sure?',
            method:  :delete
  end

  def back_link
    link_to 'Back',
            send("#{controller_name}_path")
  end

  def show_link(instance)
    link_to('Show', instance) unless instance.id.nil?
  end

  def edit_link(instance)
    link_to 'Edit',
            send("edit_#{controller_name.singularize}_path", instance)
  end

end
