class CommentsController < ApplicationController
  # GET /posts/:post_id/comments
  # GET /posts/:post_id/comments.xml
  def index
    #1st you retrieve the post thanks to params[:post_id]
    post = Post.find(params[:post_id])
    #2nd you get all the comments of this post
    @comments = post.comments
  end

  # GET /posts/:post_id/comments/:id
  # GET /comments/:id.xml
  def show
    #1st you retrieve the post thanks to params[:post_id]
    post = Post.find(params[:post_id])
    #2nd you retrieve the comment thanks to params[:id]
    @comment = post.comments.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /posts/:post_id/comments/new
  # GET /posts/:post_id/comments/new.xml
  def new
    #1st you retrieve the post thanks to params[:post_id]
    post = Post.find(params[:post_id])
    #2nd you build a new one
    @comment = post.comments.new


  end

  # GET /posts/:post_id/comments/:id/edit
  def edit
    #1st you retrieve the post thanks to params[:post_id]
    post = Post.find(params[:post_id])
    #2nd you retrieve the comment thanks to params[:id]
    @comment = post.comments.find(params[:id])
  end

  # POST /posts/:post_id/comments
  # POST /posts/:post_id/comments.xml
  def create
    #1st you retrieve the post thanks to params[:post_id]
    @post = Post.find(params[:post_id])
    #2nd you create the comment with arguments in params[:comment]
    @comment = @post.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.'}
        format.json { render :show, status: :created, location: [@comment.post,@comment]}
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/:post_id/comments/:id
  # PUT /posts/:post_id/comments/:id.xml
  def update
    post = Post.find(params[:post_id])
    #2nd you retrieve the comment thanks to params[:id]
    @comment = post.comments.find(params[:id])
   respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@comment.post,@comment], notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: [@comment.post,@comment]}
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/:post_id/comments/1
  # DELETE /posts/:post_id/comments/1.xml
  def destroy
    post = Post.find(params[:post_id])
    #2nd you retrieve the comment thanks to params[:id]
    @comment = post.comments.find(params[:id])
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to post_comments_url, notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
  end
private
     def set_comment
      post = Post.find(params[:post_id])
      @comment = post.comments.find(params[:id])
    end
     def comment_params
      params.require(:comment).permit(:post_id, :body)
    end

end
