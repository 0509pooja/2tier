output "private_key_pem" {
  value     = tls_private_key.client_key.private_key_pem
  sensitive = true
}

output "key_name" {
  value = aws_key_pair.client_key.key_name
}
  