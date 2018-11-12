Bundler.require
run TheSmallestRailsApp ||= Class.new(Rails::Application) {
  config.secret_key_base = routes.append {
    root to: proc {
      [200, {"Content-Type" => "text/html"}, [Markaby::Builder.new.html {
        title @title = "The Smallest Rails App"
        h3 "I am #@title!"
        p "Hello, world!"
      }]]
    }
  }.to_s
  initialize!
}
