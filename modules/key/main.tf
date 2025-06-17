
resource "tls_private_key" "client_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "client_key" {
  key_name   = "client_key"
  public_key = tls_private_key.client_key.public_key_openssh
}

resource "local_file" "client_private_key" {
  content          = tls_private_key.client_key.private_key_pem
  filename         = "${path.module}/client_key.pem"
  file_permission  = "0600"
}
