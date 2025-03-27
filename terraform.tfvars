# General Configurations
# region         = "us-east-1"

# ECS Configuration
# ecs_cluster_name   = "wordpress-cluster"
# ecs_service_name   = "wordpress-service"
# ecs_task_family    = "wordpress"
# ecs_cpu           = "256"
# ecs_memory        = "512"

# Docker Image & Repository Credentials
# wordpress_image     = "docker.io/library/wordpress:latest"
# docker_secret_arn   = "arn:aws:secretsmanager:us-east-1:831926591252:secret:dockerhub_details-XML1GI"

# Database Configuration
db_username   = "admin"
db_password   = "SecurePass123!"
db_name       = "wordpress_db"

# # Networking
# vpc_id           = "vpc-xxxxxxxx"
# subnet_ids       = ["subnet-xxxxxxx", "subnet-yyyyyyy"]
# security_group_id = "sg-xxxxxxxx"

# # ALB Configuration
# alb_name            = "wordpress-alb"
# alb_security_group  = "sg-yyyyyyyy"
# alb_listener_port   = 443  # HTTPS
# alb_target_group    = "wordpress-tg"

# # ACM (SSL) Certificate
# ssl_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/xxxxxxxxxxxxx"

# # Logging
# cloudwatch_log_group = "/ecs/wordpress"
