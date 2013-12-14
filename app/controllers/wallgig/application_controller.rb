module Wallgig
  class ApplicationController < ::ApplicationController
    skip_before_filter :verify_authenticity_token
    before_filter :exclude_user_root_in_json
    respond_to :json

    private
      def exclude_user_root_in_json
        User.include_root_in_json = false
      end
  end
end