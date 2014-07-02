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

  def class_if(bool)
    'class="current"'.html_safe if bool
  end

  def class_if_current_page(compared_url)
    class_if request.original_url == compared_url
  end


  # Temporary

  def fake_pp_url(user)
    return 'users/remy.jpg' if user.email == 'm@rhannequin.com'
    i = user.email.split('-').first
    g = user.gender[0,1]
    "users/#{i}-#{g}.jpg"
  end

end
