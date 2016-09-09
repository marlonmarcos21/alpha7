class HackerNewsController < ApplicationController
  def index
    @results = hn_request.results(params[:page] || 0)
  end

  private

  def hn_request
    @hn_request ||= HackerNewsRequest.new
  end
end
