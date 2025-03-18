module SeoConcern
  extend ActiveSupport::Concern

  included do
    helper_method :set_seo_meta_tags
  end

  # Method to set SEO meta tags
  def set_seo_meta_tags(title: nil, description: nil, keywords: nil)
    default_title = "Default Website Title"
    default_description = "This is the default description for SEO purposes."
    default_keywords = "default, keywords"

    title ||= default_title
    description ||= default_description
    keywords ||= default_keywords

    @meta_tags = {
      title: title,
      description: description,
      keywords: keywords
    }
  end
end
