#
# Cookbook Name:: cloudwatch::delete
# Recipe:: default
#
# Copyright 2016, danny
#
# All rights reserved - Do Not Redistribute
#

name = node[:cloudwatch][:name]
aws_instance_id = node[:opsworks][:instance][:aws_instance_id]

['cpu', 'memory', 'disk'].each do |metric|
  bash 'Delete Alarm' do
    code <<-END
      aws cloudwatch delete-alarms \
      --region ap-northeast-1 \
      --alarm-names #{name}-#{metric}-#{aws_instance_id}
    END
  end
end
