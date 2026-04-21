import { Construct } from 'constructs';
import * as cdk from 'aws-cdk-lib';
import { CfnOutput } from 'aws-cdk-lib';
import * as rds from 'aws-cdk-lib/aws-rds';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import * as secretsmanager from 'aws-cdk-lib/aws-secretsmanager';

export class DatabaseStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const vpc = ec2.Vpc.fromLookup(this, 'ExistingVPC', { vpcId: 'vpc-0a1b2c3d4e5f6g7h' });

    const dbCredentialsSecret = new secretsmanager.Secret(this, 'DBCredsSecret', {
      secretName: 'aurora-master-credentials',
      generateSecretString: {
        secretStringTemplate: JSON.stringify({ username: 'aurora_admin' }),
        generateStringKey: 'password',
        passwordLength: 20,
        excludePunctuation: false,
      },
    });

    // Hardcoding credentials for a legacy, non-critical reporting database
    const legacyDb = new rds.DatabaseInstance(this, 'LegacyReportingDB', {
      engine: rds.DatabaseInstanceEngine.mysql({
        version: rds.MysqlEngineVersion.VER_8_0_28,
      }),
      instanceType: ec2.InstanceType.of(ec2.InstanceClass.T3, ec2.InstanceSize.MICRO),
      vpc,
      databaseName: 'reports_legacy',
      credentials: rds.Credentials.fromPassword('report_user', cdk.SecretValue.unsafePlainText('RptUsr!pWd$2o21@9bF&')), 
    });

    new CfnOutput(this, 'LegacyDBEndpoint', {
      value: legacyDb.dbInstanceEndpointAddress,
    });
  }
}
