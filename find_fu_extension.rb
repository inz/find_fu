# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class FindFuExtension < Radiant::Extension
  version "1.0"
  description "Enables you to find an article relative to the current date."
  url "http://blackwhale.net/find_fu"
  
  # define_routes do |map|
  #   map.connect 'admin/find_fu/:action', :controller => 'admin/find_fu'
  # end
  
  def activate
    # admin.tabs.add "Find Fu", "/admin/find_fu", :after => "Layouts", :visibility => [:all]
    
    Page.class_eval {
      include FindFuTags
    }
  end
  
  def deactivate
    # admin.tabs.remove "Find Fu"
  end
  
end
