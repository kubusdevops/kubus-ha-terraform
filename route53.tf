# resource "aws_route53_record" "kubus_route53" {
#     zone_id = var.route53_zone_id
#     name    = var.route53_record_name
#     type    = "A"
    
#     alias {
#         name                   = aws_lb.kubus_ha_lb.dns_name
#         zone_id                = aws_lb.kubus_ha_lb.zone_id
#         evaluate_target_health = true
#     }
  
# }