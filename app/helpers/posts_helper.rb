module PostsHelper
  def new_or_show_reply(comment)
    if comment.replies.empty?
      link_to 'スレッドを開始する', new_comment_reply_path(comment.id)
    else
      link_to 'スレッドをみる', comment_path(comment.id)
    end
  end
end
