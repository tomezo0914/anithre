module ApplicationHelper
  include CustomTagHelper

  def get_ip
    if request.present?
      return request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    end
    nil
  end
end
