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
 
  desc %{
   Renders the containing elements only if the page's url matches the regular expression
   given in the @matches@ attribute. If the @ignore_case@ attribute is set to false, the
   match is case sensitive. By default, @ignore_case@ is set to true.
   
   Additionally you will have access to any backreferences defined in the regular expression using @<r:match [id="0"] />@.
 
   *Usage:*
   <pre><code><r:if_url matches="regexp" [ignore_case="true|false"]>...</if_url></code></pre>
  }
  tag 'if_url_with_match' do |tag|
   raise TagError.new("`if_url_with_match' tag must contain a `matches' attribute.") unless tag.attr.has_key?('matches')
   regexp = build_regexp_for(tag, 'matches')
   match = tag.locals.page.url.match(regexp)
   unless match.nil?
     tag.locals.match = match
     tag.expand
   end
  end
 
  desc %{
   Renders a field matched by the parent @<r:if_url ...>@ regular expression.
 
   You can optionally specify the @id@ of the matched field/backreference 
   (defaults to the first matched field).
 
   *Usage*:
   <pre><code><r:match [id="1"] /></code></pre>
  }
  tag 'match' do |tag|
    raise TagError.new("`match' tag must be child of `if_url_with_match' tag.") unless tag.locals.match
    match = tag.locals.match
    id = (tag.attr["id"] || 1).to_i
    logger.info ">>> MATCH: #{match[id]}"
    match[id]
  end

end
