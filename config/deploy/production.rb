# config/deploy/production.rb

server 'root@localhost:2222', user: 'root', roles: %w{app web}