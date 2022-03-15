class Application

  # Rack compatible app
  # this uses rack interface 
  def call(env)
    # [respose_code, headers[Hash], response_body[Array]]
    [200, {}, ["Hello World"]]
  end
end