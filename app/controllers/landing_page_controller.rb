class LandingPageController < ApplicationController

  # Allows Unauthorized Users to view the Landing Page
  skip_before_action :authenticate_user!

  # "Index" View is the Landing Page itself
  def index
  end

end
