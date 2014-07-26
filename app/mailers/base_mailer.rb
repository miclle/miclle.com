# coding: utf-8
class BaseMailer < ActionMailer::Base

  default :from => "no-reply@miclle.com"

  default :charset => "utf-8"

  default :content_type => "text/html"

  default_url_options[:host] = "miclle.com"

  layout 'mailer'

  # helper :topics, :users
end
