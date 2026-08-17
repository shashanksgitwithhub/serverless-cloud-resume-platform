resource "aws_cloudfront_origin_access_control" "s3_oac" {
  name                              = "oac-shashanktj.com.s3.ap-south-2.amazonaws.com-msisic8i11d"
  description                       = "Created by CloudFront"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "resume_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  http_version        = "http2"
  price_class         = "PriceClass_All"

  tags = {
    Name = "My_Website_Distribution"
  }

  aliases = ["shashanktj.com"]

  origin {
    domain_name              = "shashanktj.com.s3.ap-south-2.amazonaws.com"
    origin_id                = "shashanktj.com.s3.ap-south-2.amazonaws.com-msirlcmsvyf"
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_oac.id
  }

  default_cache_behavior {
    target_origin_id       = "shashanktj.com.s3.ap-south-2.amazonaws.com-msirlcmsvyf"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = [
      "GET",
      "HEAD"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"

    compress = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:470829880485:certificate/9c74eb73-25bb-4503-b636-f65a29931449"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  web_acl_id = "arn:aws:wafv2:us-east-1:470829880485:global/webacl/CreatedByCloudFront-4f6d3762/79079e30-0d8c-4415-8538-5ff419dd6267"
}