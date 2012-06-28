package 'sqlite3'
package 'libsqlite3-dev'
package 'nodejs'

cookbook_file '/tmp/app.tar.gz' do
  source 'demo_rails_app.tar.gz'
end

cookbook_file '/opt/nginx/conf/nginx.conf' do
  source 'nginx.conf'
end

directory '/opt/nginx/sites' do
  owner 'nobody'
  action :create
end

directory '/opt/nginx/sites/demo_app' do
  owner 'nobody'
  action :create
end

bash 'site installer' do
  code <<-EOH
  tar zxf /tmp/app.tar.gz -C /opt/nginx/sites/demo_app
  chown -R nobody /opt/nginx/sites/demo_app
  cd /opt/nginx/sites/demo_app
  bundle install --deployment
  EOH
end  

execute 'start nginx' do
  command '/opt/nginx/sbin/nginx'
end

