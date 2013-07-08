module RenderAnywhere
    
    class DummyController
        def logger
            RAILS_DEFAULT_LOGGER
        end
        def headers
            {}
        end
    end
    
    def render(options, assigns = {})
        viewer = ActionView::Base.new(Rails::Configuration.new.view_path, assigns, DummyController.new)
        viewer.render options
    end
    
    def template_exists?(path, assigns = {})
        viewer = ActionView::Base.new(Rails::Configuration.new.view_path, assigns, DummyController.new)
        viewer.pick_template_extension(path) rescue false
    end
end