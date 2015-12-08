#
# Cookbook Name:: devops-cookbooks
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'yum-epel'

# nginx
package "nginx" do
    action :install
end

service "nginx" do
    supports :status => true, :restart => true, :reload => true
    action [:enable, :start]
end

template "site.conf" do
    path "/etc/nginx/conf.d/default.conf"
    source "site.conf.erb"
    owner "root"
    group "root"
    mode 0644
    notifies :reload, 'service[nginx]'
end

template "index.html" do
    path "/usr/share/nginx/html/index.html"
    source "index.html.erb"
    owner "root"
    group "root"
    mode 0644
    sensitive true
end



