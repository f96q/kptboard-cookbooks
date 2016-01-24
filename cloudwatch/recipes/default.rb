#
# Cookbook Name:: cloudwatch
# Recipe:: default
#
# Copyright 2016, danny
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cloudwatch_monitoring'

def actions_option(name, actions)
  (actions || []).empty? ? '' : name + ' ' + actions.map { |action| "\"#{action}\"" }.join(' ')
end

name = node[:cloudwatch][:name]
aws_instance_id = node[:opsworks][:instance][:aws_instance_id]
ok_actions = actions_option('--ok-actions', node[:cloudwatch][:ok_actions])
alarm_actions = actions_option('--alarm-actions', node[:cloudwatch][:alarm_actions])
insufficient_data_actions = actions_option('--insufficient-data-actions', node[:cloudwatch][:insufficient_data_actions])

bash 'CPUUtilization > 90' do
  code <<-END
    aws cloudwatch put-metric-alarm \
    --region ap-northeast-1 \
    --alarm-name #{name}-cpu-#{aws_instance_id} \
    --namespace "AWS/EC2" \
    --metric-name CPUUtilization \
    --dimensions Name=InstanceId,Value=#{aws_instance_id} \
    --statistic Maximum \
    --threshold 90 \
    --period 300 \
    --evaluation-periods 1 \
    --comparison-operator GreaterThanThreshold \
    #{ok_actions} \
    #{alarm_actions} \
    #{insufficient_data_actions}
  END
end

bash 'MemoryUtilization > 90' do
  code <<-END
    aws cloudwatch put-metric-alarm \
    --region ap-northeast-1 \
    --alarm-name #{name}-memory-#{aws_instance_id} \
    --namespace "System/Linux" \
    --metric-name MemoryUtilization \
    --dimensions Name=InstanceId,Value=#{aws_instance_id} \
    --statistic Maximum \
    --threshold 90 \
    --period 300 \
    --evaluation-periods 1 \
    --comparison-operator GreaterThanThreshold \
    #{ok_actions} \
    #{alarm_actions} \
    #{insufficient_data_actions}
  END
end

bash 'DiskSpaceUtilization > 90' do
  code <<-END
    aws cloudwatch put-metric-alarm \
    --region ap-northeast-1 \
    --alarm-name #{name}-disk-#{aws_instance_id} \
    --namespace "System/Linux" \
    --metric-name DiskSpaceUtilization \
    --dimensions '[{"Name":"InstanceId","Value":"#{aws_instance_id}"},{"Name":"Filesystem","Value":"/dev/xvda1"},{"Name":"MountPath","Value":"/"}]' \
    --statistic Maximum \
    --threshold 90 \
    --period 300 \
    --evaluation-periods 1 \
    --comparison-operator GreaterThanThreshold \
    #{ok_actions} \
    #{alarm_actions} \
    #{insufficient_data_actions}
  END
end
