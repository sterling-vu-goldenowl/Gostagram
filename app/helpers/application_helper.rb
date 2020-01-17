# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Instagram'
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def avatar_for(user)
    image_tag(user.avatar.url.nil? ? 'user-avatar.png' : user.avatar.url, alt: user.username)
  end

  def current_user?(user)
    user == current_user
  end
end
