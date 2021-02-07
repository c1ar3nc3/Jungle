class AboutController < ApplicationController
  def index
    @active_sale = Sale.active.first
  end
end
