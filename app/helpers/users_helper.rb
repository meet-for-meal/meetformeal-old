module UsersHelper
  def tag_list_links(tags)
    tags.map! { |k| link_to "##{k}", '#' }.join(', ').html_safe
  end
end
