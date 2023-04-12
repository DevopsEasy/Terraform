module "apacheserver" {
  source = "./modules/apacheserver"
  
}

output "awswebserverip" {
  value = "${module.apacheserver.apacheip}"
}
