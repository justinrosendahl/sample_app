module UsersHelper
  def gravatar_for (user)
    options = { :size => 50,
                :alt => user.name,
                :class => 'gravatar'}
    gravatar_image_tag(user.email.downcase, options)
  end
end
