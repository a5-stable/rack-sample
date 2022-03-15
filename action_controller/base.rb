module ActionController
  class Base
    def render_action(action_name)
      send action_name

      unless render_something?
        # render default template
        render_template action_name ## 実装していない
      end

      [status, header, body]
    end
  end
end

## actual code
# module BasicImplicitRender # :nodoc:
#   def send_action(method, *args)
#     super.tap { default_render unless performed? }
#   end

#   def default_render
#     head :no_content
#   end
# end