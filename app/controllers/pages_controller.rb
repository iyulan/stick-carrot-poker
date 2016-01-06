class PagesController < ApplicationController
  skip_before_action :require_login, only: [:welcome]

  def welcome
  end

  def main
  end
end
