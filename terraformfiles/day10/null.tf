resource "null_resource" "sample" {
  provisioner "local-exec" {
      command = "echo hello world"
  }
}



resource "null_resource" "sample" {
    triggers = {
        id = timestamp()
    }
  provisioner "local-exec" {
      command = "echo hello world"
  }
}