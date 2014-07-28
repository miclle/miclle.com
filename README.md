# Miclle

###美摄图志: 记录精彩瞬间 还原真实影像

## Requirements

Rails 4.0.2  
MySQL 5.5  
unicorn  
redis 2.8.4

## Front-End Framework
* semantic-ui
  >http://semantic-ui.com/collections/form.html  
  >gem: semantic-ui-sass
* jQuery
* keymaster
* jQuery-File-Upload
* JavaScript-Load-Image
* JavaScript-Canvas-to-Blob

## Map API
>https://developers.google.com/maps/documentation/

##nginx config
	################## cdn source ##################
	server {	
	    listen       80;
	    server_name public.miclle.com;
	    root /home/user_home/www/miclle/public;
	}
	
	#################### server ####################
	upstream miclle_backend {
	  server unix:/tmp/unicorn.miclle.sock fail_timeout=0;
	}
	
	server {
	  listen 80;
	  server_name miclle.com www.miclle.com;
	  client_max_body_size 20M;
	  root /home/user_home/www/miclle/public;
	
	  location ~* ^(/assets|/favicon.ico) {
	    access_log        off;
	    expires           max;
	  }
	
	  location / {
	    proxy_redirect     off;
	    proxy_set_header   Host $host;
	    proxy_set_header   X-Forwarded-Host $host;
	    proxy_set_header   X-Forwarded-Server $host;
	    proxy_set_header   X-Real-IP        $remote_addr;
	    proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
	    proxy_buffering    on;
	    proxy_pass         http://miclle_backend;
	  }
	}

##unicorn
	# start
	unicorn_rails -D -c config/unicorn.rb -E production
	
	# restart
	kill -USR2 `cat tmp/pids/unicorn.pid`
	
	# stop
	kill -9 `cat tmp/pids/unicorn.pid`
	
##Sidekiq service
	# Sidekiq
	# stop
	bundle exec sidekiqctl quiet tmp/pids/sidekiq.pid  
	bundle exec sidekiqctl stop tmp/pids/sidekiq.pid  
	
	# start
	# ensure that redis has started up	
	nohup bundle exec sidekiq -e production -C config/sidekiq.yml -P tmp/pids/sidekiq.pid >> log/sidekiq.log 2>&1 &
	
	#god start/stop
	

#License
Code released under the MIT license.
