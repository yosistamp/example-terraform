# example-terraform

Terraformテンプレート

## initialize

Terraformのtfstateを管理するS3およびDynamoDBを作成する

### リソース作成

```bash
terraform init
terraform plan
terraform apply
```

## rds-template

VPCとRDSを作成するテンプレート

### リソース作成

```bash
terraform init -backend-config="bucket=<initializeで作成したバケット名>"
terraform plan
terraform apply
```

## Terraform 再実行時の注意点

シークレットがすぐには削除されないので、エラーが発生する。

```text
You can't create this secret because a secret with this name is already scheduled for deletion.
```

上記エラーが発生した際は、AWS CLIからシークレットを強制削除する。

```bash
aws secretsmanager delete-secret --secret-id db-credentials-default --force-delete-without-recovery
```