job "csp-consumer" {
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
        image = "https://registry.home.lab:5000/csp-consumer:latest"
        auth {   
          username = "admin"
          password = "password"
        }
      }
      resources {
        #cpu    = 1000
        memory = 200
        network {
          mbits = 10
        }
      }
      service {
        name = "csp-consumer"
      }
    }
  }
}
