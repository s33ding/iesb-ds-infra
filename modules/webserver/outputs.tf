output "public_ip" {
  value = aws_instance.myapp-server.public_ip
}

output "webserver_security_group_id" {
  value = aws_security_group.webserver_sg.id
}

