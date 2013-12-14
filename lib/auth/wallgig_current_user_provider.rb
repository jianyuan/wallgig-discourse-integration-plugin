require_dependency 'auth/current_user_provider'

class Auth::WallgigCurrentUserProvider < Auth::DefaultCurrentUserProvider
  TOKEN_COOKIE = ' _forums_auth_token'
end