CloudFormation do

  EC2_SecurityGroup(:SecurityGroup) do
    VpcId Ref('VPCId')
    GroupDescription "#{external_parameters[:component_name]} for MSK"
    Metadata({
      cfn_nag: {
        rules_to_suppress: [
          { id: 'F1000', reason: 'ignore egress for now' }
        ]
      }
    })
  end
  Output(:SecurityGroup) {
    Value(Ref(:SecurityGroup))
    Export FnSub("${EnvironmentName}-#{external_parameters[:component_name]}-SecurityGroup")
  }

  ingress_rules = external_parameters.fetch(:ingress_rules, [])
  ingress_rules.each_with_index do |ingress_rule, i|
    EC2_SecurityGroupIngress("IngressRule#{i+1}") do
      Description ingress_rule['desc'] if ingress_rule.has_key?('desc')
      if ingress_rule.has_key?('cidr')
        CidrIp ingress_rule['cidr']
      else
        SourceSecurityGroupId ingress_rule.has_key?('source_sg') ? ingress_rule['source_sg'] :  Ref(:SecurityGroup)
      end
      GroupId ingress_rule.has_key?('dest_sg') ? ingress_rule['dest_sg'] : Ref(:SecurityGroup)
      IpProtocol ingress_rule.has_key?('protocol') ? ingress_rule['protocol'] : 'tcp'
      FromPort ingress_rule['from']
      ToPort ingress_rule.has_key?('to') ? ingress_rule['to'] : ingress_rule['from']
    end
  end

  cluster_name = external_parameters.fetch(:cluster_name, "${EnvironmentName}-msk-cluster")
  MSK_Cluster(:KafkaCluster) do
    ClusterName FnSub("#{cluster_name}")
    KafkaVersion external_parameters[:kafka_version]
    NumberOfBrokerNodes Ref(:NumberOfBrokerNodes)
    BrokerNodeGroupInfo do
      InstanceType Ref(:KafkaInstanceType)
      ClientSubnets Ref(:Subnets)
      SecurityGroups [Ref(:SecurityGroup)]
    end
  end

  Output('SecurityGroup') do
    Value(Ref(:SecurityGroup))
    Export FnSub("${EnvironmentName}-#{external_parameters[:component_name]}-SecurityGroup")
  end

end