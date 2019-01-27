job "lb" {
  region = "global"
  datacenters = ["dc1"]
  type = "service"
  #update {
  #  max_parallel = 1
  #  stagger = "30s"
  #} 
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
    constraint {
      operator  = "distinct_hosts"
      value     = "true"
    } 
    task "development" {
      driver = "docker"
      config {   
        image = "https://registry.home.lab:5000/lb:latest"
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
        memory = 150
        network {
          mbits = 10
          port "http" { static = "9292" }
        }
      }
      service {
        name = "lb"
      }
    }
  }
}

