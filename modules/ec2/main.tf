resource "aws_security_group" "web" {
  vpc_id = var.vpc_id
  name   = "web-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "alb" {
  name               = "multi-tier-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [aws_security_group.web.id]
}

resource "aws_lb_target_group" "tg" {
  name     = "multi-tier-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_instance" "web" {
  count           = 2
  ami             = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  subnet_id       = element(var.public_subnet_ids, count.index)
  security_groups = [aws_security_group.web.id]
  key_name        = var.key_name

  tags = {
    Name = "WebServer-${count.index}"
  }
}

resource "aws_lb_target_group_attachment" "tg_attach" {
  count            = 2
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "sg_id" {
  value = aws_security_group.web.id
}
