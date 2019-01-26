job "esb" {
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
        image = "https://registry.home.lab:5000/esb:latest"
        auth {   
          username = "admin"
          password = "password"
        }
        port_map {
          amqp = 5672
          http = 15672
        }
      }
      resources {
        #cpu    = 1000
        memory = 512
        network {
          mbits = 10
          port "amqp" { static = "5555" }
          port "http" { static = "5556" }
        }
      }
      service {
        name = "esb"
        tags = ["global", "broker"]
        port = "amqp"
        check {
          name = "alive-amqp"
          type = "tcp"
          interval = "10s"
          timeout = "2s"
        }
      }
    }
  }
}
