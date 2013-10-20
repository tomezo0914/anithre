class SessionController < AnithreController
  def callback
    auth = request.env["omniauth.auth"]
    omniuser = Omniuser.get_twitter_by_uid(auth["uid"])
    if omniuser.present?
      session[:user_info] = omniuser.id
      redirect_to controller: "top", action: "index"
    else
      Omniuser.create(auth)
      redirect_to controller: "top", action: "index"
    end
  end

  def destroy
    session[:user_info] = nil
    redirect_to controller: "top", action: "index"
  end
end
