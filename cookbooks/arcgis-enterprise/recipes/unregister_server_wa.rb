#
# Cookbook Name:: arcgis-enterprise
# Recipe:: unregister_server_wa
#
# Copyright 2023 Esri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

arcgis_enterprise_server 'Unregister ArcGIS Server Web Adaptors' do
  use_join_site_tool node['arcgis']['server']['use_join_site_tool']
  server_url node['arcgis']['server']['url']
  install_dir node['arcgis']['server']['install_dir']
  username node['arcgis']['server']['admin_username']
  password node['arcgis']['server']['admin_password']
  ignore_failure true
  action :unregister_web_adaptors
end
