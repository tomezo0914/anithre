class RedirectController < AnithreController
  def index
    _params = index_params
    @url = _params[:u]
    respond_to do |format|
      format.html { render :layout => nil }
    end
  end

  private

  def index_params
    params.permit(:u)
  end

end
