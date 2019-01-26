job "check-dns" {
  region = "global"
  datacenters = ["dc1"]
  type = "service"
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
        image = "https://registry.home.lab:5000/check-dns:latest"
        auth {   
          username = "admin"
          password = "password"
        }
        port_map {
        }
      }
      resources {
        #cpu    = 1000
        memory = 205
        network {
          mbits = 10
        }
      }
      service {
        name = "check-dns"
      }
    }
  }
}
