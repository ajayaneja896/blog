class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
#above is a filter that will run code in the set_post method before the specified methods in the array i.e. show edit update and destroy
  before_action :authenticate, except: [:index,:show,:toppost]
  impressionist :actions=>[:show,:index]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        emailer(@post.title)
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
def toppost
  @a=Hash.new(0)
  @user = Post.all
  @user.each do |x|
    count=x.impressionist_count
    @a[x.id.to_s]=count
  end
   @b=@a.sort_by{|key,value| value}
   @b=@b.first(3)
   @final=Array.new
   @b.each do |x|
     id = x[0].to_i
    c=Post.find_by(id: id)
    @final<<c
   end
   @a1=Hash.new(0)
   @user1 = Post.all
   @user1.each do |x1|
     count1=x1.impressionist_count(:start_date => Date.today.beginning_of_month)
     @a1[x1.id.to_s]=count1
   end
    @b1=@a1.sort_by{|key1,value1| value1}
    @b1=@b1.first(3)
    @final1=Array.new
    @b1.each do |x1|
      id1 = x1[0].to_i
     c1=Post.find_by(id: id1)
     @final1<<c1
    end
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
    def authenticate
      unless admin?
        flash[:error] = "Unauthorized Access"
       redirect_to posts_url
    end
  end
    def emailer (heading)

      @usr = Follower.all
      mg_client = Mailgun::Client.new "key-e9aecb44c02d25be24730fe756ad4eb5"

   # Define your message parameters
    @usr.each do |usr|
   message_params = {:from    => 'ajay@sandbox7cdd3ad717ad41e69d1a2b55d184e097.mailgun.org',
                     :to      =>  "#{usr.email}",
                     :subject => 'new post at inkedinsanity',
                     :text    => " hey  #{usr.name} ew post at inkedinsanity with title #{heading}. see it here  http://localhost:3000 "}

   # Send your message through the client
   mg_client.send_message "sandbox7cdd3ad717ad41e69d1a2b55d184e097.mailgun.org", message_params
    end
end
end
