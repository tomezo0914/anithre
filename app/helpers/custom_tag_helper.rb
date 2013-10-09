module CustomTagHelper
  def head_title(title, suffix = true)
    if title.nil?
      title = 'Anithre'
    else
      title = suffix ? "#{title} - Anithre" : title
    end
    @head_title = title
  end

  def javascript_lazy_include_tag(*sources)
    @content_for_javascripts ||= []
    @content_for_javascripts << capture do
      javascript_include_tag *sources
    end
  end
end
