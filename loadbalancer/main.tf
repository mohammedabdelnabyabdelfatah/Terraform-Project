resource "aws_lb" "public" {
  name               = "public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_sg_id]
  subnets            = [var.public_subnet_az1_id, var.public_subnet_az2_id]

  tags = {
    Name = "public-lb"
  }
}

resource "aws_lb_target_group" "public_tg" {
  name     = "proxy-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "80"
  }

  tags = {
    Name = "proxy-tg"
  }
}

resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_tg.arn
  }
}

# Private Load Balancer (frontend for backend)
resource "aws_lb" "private" {
  name               = "private-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.private_sg_id]
  subnets            = [var.private_subnet_az1_id, var.private_subnet_az2_id]

  tags = {
    Name = "private-lb"
  }
}

resource "aws_lb_target_group" "private_tg" {
  name     = "backend-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "80"
  }

  tags = {
    Name = "backend-tg"
  }
}

resource "aws_lb_listener" "private_listener" {
  load_balancer_arn = aws_lb.private.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_tg.arn
  }
}
