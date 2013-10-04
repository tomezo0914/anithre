class ContentController < AnithreController
  def show
    _params = show_params
    @content = Content.get_content_by_id(_params[:id].to_i, status: Content::Status[:public])
  end

  def create
    if request.post?
      @content = Content.create
    else
    end
  end

  def edit
    if request.post?
      @content = Content.edit
    else
      @content = Content.get_content_by_id(_params[:id].to_i, user_id: user_id)
    end
  end

  private

  def show_params
    params.permit(:id)
  end

end
