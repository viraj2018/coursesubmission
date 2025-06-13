resource "aws_key_pair" "deployer" {
  key_name   = "ssh-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEkbgQEgUUgAS/KVjjmJnWOCTDaZKXo1f4bABvcrRvZ7 ubuntu@ip-172-31-89-79"
}
resource "aws_instance" "bastion" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.medium"
  associate_public_ip_address = true
  key_name =    resource.aws_key_pair.deployer.key_name
  vpc_security_group_ids = [module.security_groups["bastion"].security_group_id]
  subnet_id              = module.vpc.public_subnets[1]
  tags = {
    Name = "Bastion"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.medium"
  key_name =    resource.aws_key_pair.deployer.key_name
  vpc_security_group_ids = [module.security_groups["web"].security_group_id]
  subnet_id              = module.vpc.private_subnets[1]
  tags = {
    Name = "JenkinsAPP"
  }
}
resource "aws_instance" "app" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.medium"
  key_name =    resource.aws_key_pair.deployer.key_name
  vpc_security_group_ids = [module.security_groups["web"].security_group_id]
  subnet_id              = module.vpc.private_subnets[0]
  tags = {
    Name = "APP"
  }
}
