provider "google" {
  credentials = file("")
  project = ""
  region  = "us-central1"
  zone    = "us-central1-b"
}

resource "google_project_service" "app_terraform" {
  project = ""
  service = "compute.googleapis.com"
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false
  delete_default_routes_on_create = true
  depends_on = [
    google_project_service.app_terraform
  ]
}

resource "google_compute_subnetwork" "private_network" {
  name          = "private-network"
  ip_cidr_range = "10.2.0.0/16"
  network       = google_compute_network.vpc_network.self_link
}


resource "google_compute_route" "private_network_internet_route" {
  name             = "private-network-internet"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc_network.self_link
  next_hop_gateway = "default-internet-gateway"
  priority    = 100
}


  resource "google_compute_router" "router" {
  name    = "quickstart-router"
  network = google_compute_network.vpc_network.self_link
}

resource "google_compute_router_nat" "nat" {
  name                               = "quickstart-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_instance" "vm_instance" {
  name         = "nginx-instance"
  machine_type = "e2-highcpu-2"

  tags = ["nginx-instance"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20210420"
    }
  }

  metadata_startup_script = <<EOT
curl -fsSL https://get.docker.com -o get-docker.sh && 
sudo sh get-docker.sh && 
sudo service docker start && 
docker pull mysql:8.0.1 &&
docker run --name my-own-mysql -e MYSQL_ROOT_PASSWORD=<.....> -d mysql:8.0.1 &&
docker pull phpmyadmin/phpmyadmin:latest &&
docker run --name my-own-phpmyadmin -d --link my-own-mysql:db -p 8081:80 phpmyadmin/phpmyadmin
EOT

  network_interface {
    network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.private_network.self_link    
    access_config {
    network_tier = "STANDARD"
    }
  }
}

resource "google_compute_firewall" "public_ssh" {
   name    = "public-ssh"
   network = google_compute_network.vpc_network.self_link

   allow {
     protocol = "tcp"
     ports    = ["22", "8080", "8081" , "3306"]
   }

   direction = "INGRESS"
   source_ranges = ["0.0.0.0/0"]
   target_tags = ["nginx-instance"]
 }