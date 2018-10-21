module UsersHelper
  def gravatar_for(user, size: 120)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def days_since_login(user)
    #(Time.now - user.last_active_at) / 8640
    distance_of_time_in_words(user.last_active_at, Time.now)
  end
end
