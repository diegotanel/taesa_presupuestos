module UsersHelper

  def gravatar_for(user, options = {:size => 50})
    gravatar_image_tag(user.email.downcase, :alt => h(user.name),
                       :class => 'gravatar',
                       :gravatar => options)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
