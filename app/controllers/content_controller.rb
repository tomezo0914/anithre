class ContentController < AnithreController
  def index
  end

  def show
    _params = show_params
    @content = Content.get_by_id(_params[:id].to_i, status: Content::Status[:public])
    render template: '/shared/error_404', status: 404 and return if @content.blank?
  end

  def auth_edit
    _params = edit_params
    user_id = 0
    if request.post?
      @content = Content.edit(_params, user_id: user_id, ip: get_ip)
    else
      @content = Content.get_by_id(_params[:id].to_i, user_id: user_id)
    end
  end

  private

  def show_params
    params.permit(:id)
  end

  def create_params
    params.permit(:title, :subtitle, :description, :episode)
  end

  def edit_params
    params.permit(:id, :title, :subtitle, :description, :episode)
  end
end
