class MoviesController < ApplicationController
  def request

    p = params['query']
    redirect_to movies_search
  end

  def search
  end
end
