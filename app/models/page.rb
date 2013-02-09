class Page < ActiveCopy::Base
  attr_accessible :title, :custom_slug

  def slug
    @slug ||= if custom_slug.present?
      custom_slug
    else
      title.parameterize
    end
  end
end
