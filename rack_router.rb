class RackRouter
  def initialize
    @table = {
      "users" => {
        "new" => { :this => [UsersController, :new] },
        :this => { :this => [UsersController, :index] },
      },
      "shops" => {
        "new" => { :this => [ShopsController, :new] },
        :this => { :this => [ShopsController, :index] },
      },
    }
  end

  def call(env)
    find_route(env["REQUEST_PATH"], @table) do |controller, action|
      [200, {}, ["Found Controller: #{controller}"]]
    end
  end

  def find_route(path, table)
    path.split("/").drop(1).inject(table).each {|t, name|
      t[name]
    }[:this]
    yield controller, action
  end
end