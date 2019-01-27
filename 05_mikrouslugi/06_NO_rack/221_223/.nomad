job "rack" {
  # region = "global"
  datacenters = ["dc1"]
  type = "service"
  constraint {   
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }
  update {
    max_parallel = 1
    stagger = "30s"
  }
  group "deploy" {
    count = 2
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
        image = "https://registry.home.lab:5000/rack:latest"
        auth {   
          username = "admin"
          password = "password"
        }
        port_map {
          http = 9292
        }
      }
      resources {
        #cpu    = 1000
        memory = 190
        network {
          mbits = 10
          port "http" {}
        }
      }
      service {
        name = "rack"
        port = "http"
        check {
         type     = "http"
         path     = "/"
         interval = "60s"
         timeout  = "10s"
        }
      }
    }
  }
}

