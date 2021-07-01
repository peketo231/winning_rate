class ApplicationController < ActionController::Base
  # Overwrite the method sorcery calls when it
  # detects a non-authenticated request.
  def not_authenticated
    # Make sure that we reference the route from the main app.
    redirect_to main_app.login_path
  end
end
