class ContentController < AnithreController
  def index
  end

  def show
    _params = show_params
    @content = Content.get_by_id(_params[:id].to_i, status: Content::Status[:public])
    render template: '/shared/error_404', status: 404 and return if @content.blank?

    page = _params[:page]
    @messages = Message.content_timeline(@content.id, status: Content::Status[:public], page: page)

    @amazon_dvd = Amazon::Ecs.item_search(@content.title, search_index: "DVD", response_group: "Medium", country: "jp")
    @amazon_hobbies = Amazon::Ecs.item_search(@content.title, search_index: "Hobbies", response_group: "Medium", country: "jp")

    #Rails.logger.debug "-----------------"
    #Rails.logger.debug @amazon.marshal_dump
    #Rails.logger.debug "-----------------"
  end

  def auth_create
    user_id = 0
    if request.post?
      _params = create_params
      @content = Content.edit(_params, user_id: user_id, ip: get_ip)
      redirect_to controller "content", action: "auth_edit", id: @content.id and return
    end
    render action: "auth_edit" and return
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

  def auth_publish
    _params = publish_params
    user_id = 0
    render template: '/shared/error_404', status: 404 and return unless request.post?

    @content = Content.publish(_params, user_id: user_id)
    redirect_to controller "content", action: "auth_edit", id: @content.id and return
  end

  private

  def show_params
    params.permit(:id, :page)
  end

  def create_params
    params.permit(:title, :subtitle, :description, :episode)
  end

  def edit_params
    params.permit(:id, :title, :subtitle, :description, :episode)
  end

  def publish_params
    params.permit(:id)
  end
end
