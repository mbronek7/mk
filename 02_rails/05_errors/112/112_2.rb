def show
  @post = Post.find(params[:slug])
  begin
    @comments = HTTParty.get(COMMENTS_SERVER, read_timeout: 10)
  rescue Net::ReadTimeout => e
    @comments = []
    @error_message = "Comments couldn't be retrieved, please try again later."
    Rollbar.error(e);
  end
end

