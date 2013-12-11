module ApplicationHelper
  include CustomTagHelper

  def get_ip
    if request.present?
      return request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    end
    nil
  end

  def nl2br(str, encode_utf: true)
    str = html_escape(str)
    str = str.gsub(/\r\n|\r|\n/, '<br />')
    str = str.gsub('&amp;#', '&#')
  end
end
