require "kemal"
require "healthcheck_handler"

add_handler(HealthcheckHandler.new)

get "/" do
  "hello world"
end

Kemal.run
