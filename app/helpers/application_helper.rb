module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def show_subscription_information(num_of_projects)
    content_tag :ul, :class => "inline", id: "subscription_information" do
      content_tag(:li, "#{num_of_projects} of #{Project.get_max_projects(current_user).to_s} Projects") +
      (content_tag(:li, "#{current_user.trial_days_count.to_i} remaining trial days") unless current_user.has_subscribed?) +
      (content_tag(:li, content_tag(:a, "Upgrade your account", href: edit_user_subscription_path(current_user, current_user.subscription), class: "btn btn-info", id: 'upgrade_from_projects')) if show_upgrade_message?) +
      content_tag(:li, content_tag(:a, 'Archives', href: archives_path))
    end
  end

  def show_upgrade_message?
    plan = current_user.get_plan
    return true if current_user.has_subscribed? && (plan == 'silver' || plan == 'gold')
    return true if !current_user.has_subscribed? && current_user.has_trial_days?
  end

end

