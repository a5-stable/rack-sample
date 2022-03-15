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

    def render_template(action_name)
      self.class # => UserController
      action.name # => index

      dir = self.class.name.sub(/Controller$/, "").downcase # => users
      path = File.join(Dir.pwd, "app/controlers", dir) # => app/controllers/users

      template = Dir.entries(path).find {|file|
        path =~ /^#{action_name}/
      } # => index.html.erb

      render_file(template)
    end

    def render_file(template)
      erb = ERB.new(File.read(template))
      erb.result # => <html>...
      # send to client as response
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