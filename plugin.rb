# name: wallgig integration
# about: user integration with main app
# version: 0.1
# author: Jian Yuan Lee

module ::Wallgig
  class Engine < ::Rails::Engine
    engine_name 'wallgig'
    isolate_namespace Wallgig
  end
end

after_initialize do

#   # require File.expand_path('../api/users_controller', __FILE__)
  load File.expand_path('../lib/auth/wallgig_current_user_provider.rb', __FILE__)

  Discourse::Application.routes.prepend do
    mount ::Wallgig::Engine => '/api'
  end

  Discourse.current_user_provider = ::Auth::WallgigCurrentUserProvider

end
