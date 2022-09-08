provider "google" {
    credentials = file("a-config-cb607e41ca2b.json") // export key-file JSON
    project = "215200687059"
    region = "us-west1"
    zone   = "us-west1-a"

    #region = "europe-west1"
    #zone = "europe-west1-b"
    #region = "us-central1-a"
    #zone = "us-central1-a"
}

resource "google_compute_instance" "proTerraform" {
    name = "DevOps_project"
    machine_type = "f1.micro"
    boot_disk {
      initialize_params{
          image = "debian-cloud/debian-9"
      }
    }

    network_interface {
      network = "default"  // this is for Enable private IP adress
    }
  
}