class Application
  def call(env)
    [200, {}, ["Hello World: " + Time.now.to_s]]
  end
end

app = Application.new