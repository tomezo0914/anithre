class MessageController < AnithreController
  def auth_create
    if request.post?
      _params = create_params
      _params[:ip] = get_ip
      @message = Message.edit(_params)
      respond_to do |format|
        format.json { render json: @message }
      end
    else
      render template: '/shared/error_404', status: 404 and return
    end
  end

  private

  def create_params
    params.permit(:content_id, :body)
  end

end
