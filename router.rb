table = {
  "users" => {
    "new" => { :this => [UsersController, :new] },
    :this => { :this => [UsersController, :index] },
  },
  "shops" => {
    "new" => { :this => [ShopsController, :new] },
    :this => { :this => [ShopsController, :index] },
  },
}

def find_route(path, table)
  path.split("/").drop(1).inject(table).each {|t, name|
    t[name]
  }[:this]
end

p find_route("/users/new", table)
p find_route("/users", table)
p find_route("/shops/new", table)
p find_route("/shops", table)