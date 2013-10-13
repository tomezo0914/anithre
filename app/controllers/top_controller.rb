class TopController < AnithreController
  def index
    @contents = Content.recently
  end
end
