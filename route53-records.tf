resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "shashanktj.com"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.resume_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.resume_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}