module UsersHelper
  def tag_list_links(tags, separator = ', ')
    tags.map { |k| link_to "##{k}", '#' }.join(separator).html_safe
  end
end
