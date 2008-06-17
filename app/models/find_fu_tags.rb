module FindFuTags 
  include Radiant::Taggable

  desc %{
    Returns children to be published after a specified date (defaults to today)..

    *Usage:*
    <pre><code><r:children:new>...</r:children:new></code></pre>
    Will return all children with a publication date after today.

    <pre><code><r:children:new limit="1">...</r:children:new</code></pre>
    Will return the first child with a publication date in the future.
  }
  tag 'children:new' do |tag|
    options = children_find_options(tag)
    attr = tag.attr.symbolize_keys
    result = []
    options[:conditions] = ["virtual = ? AND published_at >= ?", false, eval(attr[:from] || 'Time.now')]
    children = tag.locals.children
    tag.locals.previous_headers = {}
    children.find(:all, options).each do |item|
      tag.locals.child = item
      tag.locals.page = item
      result << tag.expand
    end 
    result
  end

  desc %{
    Returns children to be published before a specified date (defaults to today)..

    *Usage:*
    <pre><code><r:children:old>...</r:children:old></code></pre>
    Will return all children with a publication date before today.
  }
  tag 'children:old' do |tag|
    options = children_find_options(tag)
    attr = tag.attr.symbolize_keys
    result = []
    options[:conditions] = ["virtual = ? AND published_at < ?", false, eval(attr[:to] || 'Time.now')]
    children = tag.locals.children
    tag.locals.previous_headers = {}
    children.find(:all, options).each do |item|
      tag.locals.child = item
      tag.locals.page = item
      result << tag.expand
    end 
    result
 end
end
