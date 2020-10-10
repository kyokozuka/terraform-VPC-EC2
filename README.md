# Terraform による AWS(VPC, EC2)の構築

<img src="https://github.com/kyokozuka/terraform-VPC-EC2/blob/main/terroform-logo.png">

## 事前準備
1. IAMにてCLIアカウント作成
2. AWS CLI による "aws configure"の作成
※ 参照”https://aws.amazon.com/jp/cli/”

# Environment
- terraform 0.12.24

## Install
1. mac
~~~
$ brew install terraform
~~~
2. windows
- 以下サイトよりダウンロード
    
    https://www.terraform.io/downloads.html

## Run
~~~
# 計画: 構築内容・変更内容の確認
$ terraform plan

# 実行
$ terraform apply
# 実行中に構築して良いかと聞かれるので'yes'と入力しEnter
~~~

## Delete
~~~
# 環境削除
$ terraform destroy
~~~
