# Creating CloudFront distribution without custom domain or ACM
resource "aws_cloudfront_distribution" "my_distribution" {
  enabled = true

  origin {
    domain_name = var.alb_domain_name
    origin_id   = var.alb_domain_name

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"  # change to "https-only" if ALB uses HTTPS
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = var.alb_domain_name
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["IN", "US", "CA"]
    }
  }
  web_acl_id = var.web_acl_id

  tags = {
    Name = var.project_name
  }

  # Use CloudFront default SSL certificate
  viewer_certificate {
    cloudfront_default_certificate = true
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"

  }
}
