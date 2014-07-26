# encoding: utf-8
class Cpanel::ApplicationController < ApplicationController

  layout "cpanel"

  before_filter :require_admin

  def require_admin
    if current_user.blank? or !['admin', 'editor'].include?(current_user.role)
      render_404
    end
  end

end
