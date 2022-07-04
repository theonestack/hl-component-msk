CfhighlanderTemplate do
  
  Parameters do
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', allowedValues: ['development','production'], isGlobal: true
    ComponentParam 'VPCId', type: 'AWS::EC2::VPC::Id'
    ComponentParam 'NumberOfBrokerNodes', 3
    ComponentParam 'KafkaInstanceType', 'kafka.t3.small'
    ComponentParam 'Subnets', type: 'CommaDelimitedList'
  end
  
end