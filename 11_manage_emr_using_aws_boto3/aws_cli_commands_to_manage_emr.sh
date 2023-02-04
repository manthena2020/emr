aws emr create-cluster \
    --os-release-label 2.0.20220426.0 \
    --termination-protected \
    --applications Name=Hadoop Name=Hive Name=Spark \
    --ec2-attributes '{"InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-0452ade8510f43c16","EmrManagedSlaveSecurityGroup":"sg-0846a8d248c6654f5","EmrManagedMasterSecurityGroup":"sg-0ce008d667fae0c7f"}' \
    --release-label emr-6.6.0 \
    --log-uri 's3n://aws-logs-269066542444-us-east-1/elasticmapreduce/' \
    --instance-groups '[{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"MASTER","InstanceType":"m5.xlarge","Name":"Master - 1"},{"InstanceCount":2,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"CORE","InstanceType":"m5.xlarge","Name":"Core - 2"}]' \
    --configurations '[{"Classification":"hive-site","Properties":{"hive.metastore.client.factory.class":"com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory"}},{"Classification":"spark-hive-site","Properties":{"hive.metastore.client.factory.class":"com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory"}}]' \
    --auto-scaling-role EMR_AutoScaling_DefaultRole \
    --ebs-root-volume-size 32 \
    --service-role EMR_DefaultRole \
    --enable-debugging \
    --auto-termination-policy '{"IdleTimeout":3600}' \
    --name 'AI Cluster' \
    --scale-down-behavior TERMINATE_AT_TASK_COMPLETION \
    --region us-east-1

aws emr create-cluster \
    --applications Name=Hadoop Name=Spark \
    --ec2-attributes '{"InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-0452ade8510f43c16","EmrManagedSlaveSecurityGroup":"sg-0846a8d248c6654f5","EmrManagedMasterSecurityGroup":"sg-0ce008d667fae0c7f"}' \
    --release-label emr-6.6.0 \
    --log-uri 's3n://aws-logs-269066542444-us-east-1/elasticmapreduce/' \
    --instance-groups '[{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"MASTER","InstanceType":"m5.xlarge","Name":"Master - 1"},{"InstanceCount":2,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":2}]},"InstanceGroupType":"CORE","InstanceType":"m5.xlarge","Name":"Core - 2"}]' \
    --configurations '[{"Classification":"spark-hive-site","Properties":{"hive.metastore.client.factory.class":"com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory"}}]' \
    --auto-scaling-role EMR_AutoScaling_DefaultRole \
    --ebs-root-volume-size 10 \
    --service-role EMR_DefaultRole \
    --enable-debugging \
    --auto-termination-policy '{"IdleTimeout":3600}' \
    --name 'AI Cluster' \
    --scale-down-behavior TERMINATE_AT_TASK_COMPLETION \
    --region us-east-1

aws emr list-clusters
aws emr list-clusters --active # Get cluster id

aws emr list-instances --cluster-id <CLUSTER_ID> # Replace with relevant cluster id
aws emr describe-cluster <CLUSTER_ID>

aws emr terminate-clusters --cluster-ids <CLUSTER_ID>