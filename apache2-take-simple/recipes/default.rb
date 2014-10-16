#
# Cookbook Name:: apache2-take-simple
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
# install apache2
#
package 'apache2' do
  case node[ :platform ]
  when 'redhat', 'centos', 'amazon'
    package_name 'httpd'
  when 'debian', 'ubuntu'
    package_name 'apache2'
  end
end
#
# set content
#
template 'index.html' do
  case node[ :platform ]
  when 'redhat', 'centos', 'amazon'
    path '/var/www/html/index.html'
  when 'debian', 'ubuntu'
    path '/var/www/index.html'
  end
  source 'index.html.erb'
  mode 0644
  variables( { :fqdn => node[ :fqdn] } )
end
#
# set auto start and restart apache2
#
service 'apache2' do
  case node[ :platform ]
  when  'redhat', 'centos', 'amazon'
    service_name 'httpd'
  when 'debian', 'ubuntu'
    service_name 'apache2'
  end
  action [ :enable, :start ]
end

