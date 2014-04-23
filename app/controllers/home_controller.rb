class HomeController < ApplicationController
  # layout :custom_layout

  def index
  end

  def main
  end

  private
    def custom_layout
      action_name != 'index' ? 'application': false
    end
end
