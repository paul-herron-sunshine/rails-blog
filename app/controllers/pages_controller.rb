class PagesController < ApplicationController
  def about
    @title = 'About';
    @content = 'This is the about page'
  end
end