module ProfilesHelper
  def new_link
    @user_name.nil? ? super() :
        link_to("New #{controller_name.humanize.singularize}",
                send("new_user_#{controller_name.singularize}_path"))
  end
end
