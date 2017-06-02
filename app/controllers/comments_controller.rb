class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy, :update, :edit]

  def create
    @comment = current_user.comments.build(comments_params)
    @blog = @comment.blog
    @notification = @comment.notifications.build(user_id: @blog.user.id)
    respond_to do |format|
      if @comment.save
        format.html{redirect_to blog_path(@blog), notice: 'コメントを投稿しました'}
        format.js {render:index}
        unless @comment.blog.user_id == current_user.id
          Pusher.trigger("user_#{@comment.blog.user_id}_channel",'comment_created',{
            message: 'あなたの作成したブログにコメントがつきました'
            })
        end
          Pusher.trigger("user_#{@comment.blog.user_id}_channel",'comment_created',{
            unread_counts: Notification.where(user_id: @comment.blog.user.id, read:false).count
          })
      else
        format.html{render :new}
      end
    end
  end


  def edit
  end

  def update
  @comment.update(comments_params)
  redirect_to blog_path(@blog)
  end


  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html{redirect_to blog_path(@blog), notice: "コメントを削除しました！"}
        format.js{render:index}
      else
        format.html{render :new}
      end
    end
  end

  private

    def comments_params
      params.require(:comment).permit(:blog_id, :content)
    end

    def set_comment
      @comment = Comment.find(params[:id])
      @blog = @comment.blog
    end
  end
