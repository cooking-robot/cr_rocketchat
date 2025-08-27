#
# Cookbook:: cr_rocketchat
# Recipe:: desktop
#
# Copyright:: 2025, The Authors, All Rights Reserved.

rc_dir = nil
case node['platform_family']
when 'debian'
  tmp_file = "#{Chef::Config['file_cache_path']}/rocketchat.deb"
  remote_file 'rocketchat.deb' do
    path tmp_file
    source "https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/#{node['rocketchat']['version']}/rocketchat-#{node['rocketchat']['version']}-linux-amd64.deb"
  end

  dpkg_package 'rocketchat' do
    source tmp_file
    action :install
  end

  # snap_package 'rocketchat-desktop' do
  #   action :install
  # end

  if node['rocketchat']['server']
    directory '/opt/Rocket.Chat/resources/' do
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
      action :create
    end 
  end
  rc_dir = '/opt/Rocket.Chat/resources'

when 'windows'
  windows_package "Rocket.Chat #{node['rocketchat']['version']}" do
    action :install
    source "https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/#{node['rocketchat']['version']}/rocketchat-#{node['rocketchat']['version']}-win-x64.exe"
    options '/allusers'
    installer_type :nsis
  end
  rc_dir = "#{ENV['ProgramFiles']}/Rocket.Chat/resources"
end

if rc_dir && node['rocketchat']['server']
  file "#{rc_dir}/servers.json" do
    content "{\"#{node['rocketchat']['server']['name']}\":\"#{node['rocketchat']['server']['url']}\"}"
    action :create
  end
end

if rc_dir && node['rocketchat']['disable_updates']
  file "#{rc_dir}/overridden-settings.json" do
    content "{\"isUpdatingEnabled\":false,\"doCheckForUpdatesOnStartup\":false}"
    action :create
  end
end