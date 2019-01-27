job "redis" {
  # region = "global"
  datacenters = ["dc1"]
  type = "service"
  constraint {   
    attribute = "${attr.unique.network.ip-address}"
    value     = "172.28.128.11"
  }
  update {
    max_parallel = 1
    stagger = "30s"
  }
  group "deploy" {
    count = 1
    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }
    ephemeral_disk {
      size = 300 
    }
    task "development" {
      driver = "docker"
      config {   
        image = "https://registry.home.lab:5000/redis:latest"
        auth {   
          username = "admin"
          password = "password"
        }
        port_map {
          redis = 6379
        }
      }
      resources {
        # cpu    = 1000
        memory = 200
        network {
          mbits = 10
          port "redis" { static = "5700" }
        }
      }
      service {
        name = "redis"
        tags = ["global", "broker"]
        port = "redis"
        check {
          name = "alive"
          type = "tcp"
          interval = "10s"
          timeout = "2s"
        }
      }
    }
  }
}
