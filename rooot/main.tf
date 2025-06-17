module "vpc" {
    source = "../modules/vpc"
    region = var.region
    project_name = var.project_name
    vpc_cidr         = var.vpc_cidr
    pub_sub_1a_cidr = var.pub_sub_1a_cidr
    pub_sub_2b_cidr = var.pub_sub_2b_cidr
    pri_sub_3a_cidr = var.pri_sub_3a_cidr
    pri_sub_4b_cidr = var.pri_sub_4b_cidr
    pri_sub_5a_cidr = var.pri_sub_5a_cidr
    pri_sub_6b_cidr = var.pri_sub_6b_cidr
}


module "nat" {
  source = "../modules/nat"

  pub_sub_1a_id = module.vpc.pub_sub_1a_id
  igw_id        = module.vpc.igw_id
  pub_sub_2b_id = module.vpc.pub_sub_2b_id
  vpc_id        = module.vpc.vpc_id
  pri_sub_3a_id = module.vpc.pri_sub_3a_id
  pri_sub_4b_id = module.vpc.pri_sub_4b_id
  pri_sub_5a_id = module.vpc.pri_sub_5a_id
  pri_sub_6b_id = module.vpc.pri_sub_6b_id
}
module "security-group" {
  source = "../modules/security-group"
  vpc_id = module.vpc.vpc_id
}

# creating Key for instances
module "key" {
  source = "../modules/key"
}

module "alb" {
  source         = "../modules/alb"
  project_name   = module.vpc.project_name
  alb_sg_id      = module.security-group.alb_sg_id
  pub_sub_1a_id = module.vpc.pub_sub_1a_id
  pub_sub_2b_id = module.vpc.pub_sub_2b_id
  vpc_id         = module.vpc.vpc_id
}
module "asg" {
  source         = "../modules/asg"
  project_name   = module.vpc.project_name
  key_name       = module.key.key_name
  client_sg_id   = module.security-group.client_sg_id
  pri_sub_3a_id = module.vpc.pri_sub_3a_id
  pri_sub_4b_id = module.vpc.pri_sub_4b_id
  tg_arn         = module.alb.tg_arn
  db_username = var.db_username
  db_password = var.db_password
  db_name     = var.db_name
  db_host     = module.rds.db_address
  
}

module "rds" {
  source         = "../modules/rds"
  db_sg_id       = module.security-group.db_sg_id
  pri_sub_5a_id = module.vpc.pri_sub_5a_id
  pri_sub_6b_id = module.vpc.pri_sub_6b_id
  db_username    = var.db_username
  db_password    = var.db_password
  
  
}
# create cloudfront distribution without custom domain or ACM
module "cloudfront" {
  source           = "../modules/cloudfront"
  alb_domain_name  = module.alb.alb_dns_name
  project_name     = module.vpc.project_name
  web_acl_id       = module.cloudfront_waf.waf_arn

}
module "cloudfront_waf" {
  source                = "../modules/waf"
  name                  = var.waf_name
  description           = var.waf_description
  scope                 = var.waf_scope
  metric_name           = var.waf_metric_name
  enable_managed_rules  = var.enable_managed_rules
  
}

# launching JUMP server or Bastion host 
module "SERVER" {
  source         = "../modules/ec2"
  JUMP_SG_ID     = module.security-group.JUMP_SG_ID
  PUB_SUB_1_A_ID = module.vpc.pub_sub_1a_id
  KEY_NAME       = module.key.key_name
}