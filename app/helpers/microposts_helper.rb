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

  def display_comment_with_avatar(comment, user)
    content_tag(:div, class: 'micropost-content') do
      dom = avatar_for(comment.user)
      dom += link_to comment.user.username, comment.user
      dom += content_tag(:pre) do
        comment.body
      end
      if comment.user == user
        dom += render partial: 'comments/delete_button', locals: { micropost: comment.micropost, comment: comment }
      end
      dom
    end
  end

  # private

  # def delete_comment(comment)
  #   content_tag(:div, id: "comment-menu-#{comment.id}", class: 'menu-overlay') do
  #     dom = content_tag(:div, class: 'overlay-content') do
  #       link_to 'Delete', micropost_comment_path(comment.micropost.id, comment.id), data: { method: :delete, confirm: "Are you sure want to delete this comment?" }
  #     end
  #   end
  # end
end
