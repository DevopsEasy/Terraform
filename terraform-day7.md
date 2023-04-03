## Terraform RDS, TAINT, OUTPUT,WORKSPACE
* We would like to create an database instance in our vpc hosting some database.
* In this exercise, lets try to create an Postgres Database in free tier.
* From the images we can make out that the following are the major inputs
* Engine => postgres/mysql/oracle/sql server
* version => which version of database
* Dbsubnet group =>
* network => vpc, subnet & security group
* instance size => db.t2.micro
* Credentials
* other settings
   * for backups
   * monitoring
   * storage size

* Adding Database:
* Creating Db subnet group from two db subnets [Refer Here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group)
* Now lets create a database from the resource [Refer Here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance).

```
resource "aws_db_subnet_group" "ntier_db" {
    name        = "ntier"
    subnet_ids  = [aws_subnet.subnets[2].id, aws_subnet.subnets[3].id]

}

# db instance

resource "aws_db_instance" "db" {
    allocated_storage           = 20
    apply_immediately           = true
    auto_minor_version_upgrade  = false
    backup_retention_period     = 0
    db_subnet_group_name        = aws_db_subnet_group.ntier_db.name
    engine                      = "postgres"
    identifier                  = "derdsfortf" 
    instance_class              = "db.t3.micro"
    multi_az                    = false
    name                        = "instacook"
    username                    = "postgres"
    password                    = "postgres" 
    vpc_security_group_ids      = [aws_security_group.dbsg.id]
    skip_final_snapshot         = true
}
```

* Generally it is a good idea to show some outputs to the users whenever they execute ``` terraform apply ```
* For writing outputs [Refer Here](https://developer.hashicorp.com/terraform/language/values/outputs) for official documentation
* Lets add two simple outputs and see the terraform output while apply
```
output "web1_publicip" {
    value = aws_instance.web_instance_1.public_ip
}

output "db_endpoint" {
    value = aws_db_instance.db.endpoint
}
```

* Lets create more outputs
    * vpc id
    * subnet id
    * security group ids
    * ec2 ip address
    * db endpoint

```
output "web1_publicip" {
    value = aws_instance.web_instance_1.public_ip
}

output "db_endpoint" {
    value = aws_db_instance.db.endpoint
}

output "vpc_id" {
    value = aws_vpc.primary_vpc.id
}
output "web1_subnet_id" {
    value = aws_subnet.subnets[0].id
}
output "web2_subnet_id" {
    value = aws_subnet.subnets[1].id
}
output "db1_subnet_id" {
    value = aws_subnet.subnets[2].id
}
output "db2_subnet_id" {
    value = aws_subnet.subnets[3].id
}
output "web_security_group_id" {
    value = aws_security_group.websg.id
}
output "db_security_group_id" {
    value = aws_security_group.dbsg.id
}

```
## Terraform plan
* All these days we were executing ``` terraform apply ``` to create infrastructure
* Terraform apply command internally creates a plan and then executes the plan
* We can explicity create a plan ``` terraform plan -out <filename> ``` and then ``` terraform apply <filename> ```

## Terraform Workspaces
* Generally when we write terraform configuration, we would like to create multiple environments such as
* Developer
* System Test
* Performance Test
* Staging
* Production
* For all the environments our infrastructure is same, the arguments might differ, There might be some additional resources in some environments
* To handle this we would not creat multiple copies of infrastructure and create different backend configurations.
* To deal with single template and multi environments terraform introduced a concept called workspaces. [Refer Here](https://www.terraform.io/language/state/workspaces) for the official docs
* Now lets explore terraform workspace cli




