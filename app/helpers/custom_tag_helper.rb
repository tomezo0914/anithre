module CustomTagHelper
  def javascript_lazy_include_tag(*sources)
    @content_for_javascripts ||= []
    @content_for_javascripts << capture do
      javascript_include_tag *sources
    end
  end
end
