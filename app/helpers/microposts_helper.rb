# frozen_string_literal: true

module MicropostsHelper
  def display_comment(micropost, comment)
    content_tag(:div, class: 'micropost-comment') do
      dom = content_tag(:div, class: 'micropost-user-avatar') do
        link_to comment.user.username, micropost.user
      end
      dom += content_tag(:div, class: 'comment-body') do
        comment.body
      end
      dom
    end
  end

  def display_comment_with_avatar(comment)
    content_tag(:div, class: 'micropost-content') do
      dom = avatar_for(comment.user)
      dom += link_to comment.user.username, comment.user
      dom += content_tag(:pre) do
        comment.body
      end
      dom
    end
  end
end
