module "network" {
  source           = "./modules/network"
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  azs              = var.azs
  db_sg_id        = module.database.db_sg_id
  security_group_id = module.network.bastion_sg_id 
}
module "database" {
  source           = "./modules/database"
  vpc_id          = module.network.vpc_id
  private_subnets = module.network.private_subnets
  db_username     = var.db_username
  db_password     = var.db_password
  bastion_sg_id   = module.network.bastion_sg_id
}

module "alb" {
  source         = "./modules/alb"
  vpc_id        = module.network.vpc_id
  public_subnets = module.network.public_subnets
}


module "ecs" {
  source               = "./modules/ecs"
  vpc_id               = module.network.vpc_id
  public_subnets       = module.network.public_subnets
  private_subnets      = module.network.private_subnets
  security_groups      = [module.alb.alb_sg_id]
  db_endpoint          = module.database.db_endpoint
  db_username          = var.db_username
  db_password          = var.db_password
  aws_lb_target_group = module.alb.target_group_arn
  http_listener_arn    = module.alb.http_listener_arn 
  alb_sg_id = module.alb.alb_sg_id
  nodejs_tg_arn  = module.alb.nodejs_tg_arn

}
