job "db" {
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
      size = 1000
    }
    task "development" {
      driver = "docker"
      config {   
        image = "postgres:9.6.10"
        port_map {
          db = 5432
        }
        volumes = [
          "/opt/db:/var/lib/postgresql/data/"
        ]
      }
      resources {
        #cpu    = 1000
        memory = 512
        network {
          mbits = 10
          port "db" { static = "5432" }
        }
      }
      service {
        name = "db"
        port = "db"
        check {
          name = "alive-db"
          type = "tcp"
          interval = "10s"
          timeout = "2s"
        }
      }
    }
  }
}
