output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "client_sg_id" {
  value = aws_security_group.client_sg.id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}
output "JUMP_SG_ID" {
  value = aws_security_group.jump_sg.id
}