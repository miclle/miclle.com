# encoding: utf-8
class Cpanel::CommentsController < Cpanel::ApplicationController

  def index
    @comments = Comment.page params[:page]
  end

end