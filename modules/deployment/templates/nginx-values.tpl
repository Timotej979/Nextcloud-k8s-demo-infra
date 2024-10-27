controller:
  service:
    annotations:
      load-balancer.hetzner.cloud/name: ${ingress_lb_name}
      load-balancer.hetzner.cloud/location: ${server_location}
      load-balancer.hetzner.cloud/use-private-ip: "true"
      load-balancer.hetzner.cloud/algorithm-type: "round_robin"
      load-balancer.hetzner.cloud/uses-proxyprotocol: "true"
      load-balancer.hetzner.cloud/hostname: ${domain_name}