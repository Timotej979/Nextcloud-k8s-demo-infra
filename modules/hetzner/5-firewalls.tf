# Firewall for Control Plane Nodes
resource "hcloud_firewall" "control_plane_firewall" {
  name = "control-plane-firewall"
  # Allow ICMP (ping)
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
  # Allow SSH access (port 22) for management
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
  # Allow access to the Kubernetes API (port 6443)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "6443"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
  # Allow communication between control plane nodes (etcd, kubelet, etcd)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "2379-2380"
    source_ips = [var.public_subnet_cidr] # Internal subnet for control plane communication
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "10250"
    source_ips = [var.public_subnet_cidr] # Worker and control plane subnet
  }
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "10255"
    source_ips = [var.public_subnet_cidr] # Worker and control plane subnet
  }
  # Apply firewall to control plane nodes
  apply_to {
    label_selector = "role=control-plane"
  }
}

# Firewall for Worker Nodes
resource "hcloud_firewall" "worker_firewall" {
  name = "worker-firewall"
  # Allow ICMP (ping)
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
  # Allow SSH access (port 22) for management
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
  # Allow communication between workers and control plane nodes on port 10250 (kubelet)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "10250"
    source_ips = [var.public_subnet_cidr] # Control plane and worker communication
  }
  # Allow communication between workers and control plane nodes on port 10255 (read-only)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "10255"
    source_ips = [var.public_subnet_cidr] # Control plane and worker communication
  }
  # Apply firewall to worker nodes
  apply_to {
    label_selector = "role=worker"
  }
}

# Firewall for PostgreSQL Database
resource "hcloud_firewall" "db_firewall" {
  name = "db-firewall"
  # Allow ICMP (ping)
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = [var.public_subnet_cidr] # Only allow ping from Kubernetes cluster (public subnet)
  }
  # Allow SSH access (port 22) for management
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = [var.public_subnet_cidr] # Restrict SSH access to the Kubernetes cluster
  }
  # Allow PostgreSQL access (port 5432)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "5432"
    source_ips = [var.public_subnet_cidr] # Allow access only from Kubernetes cluster nodes
  }
  # Apply firewall to the PostgreSQL database instance
  apply_to {
    label_selector = "role=db"
  }
}

# Firewall for Redis Cache
resource "hcloud_firewall" "redis_firewall" {
  name = "redis-firewall"
  # Allow ICMP (ping)
  rule {
    direction  = "in"
    protocol   = "icmp"
    source_ips = [var.public_subnet_cidr] # Only allow ping from Kubernetes cluster (public subnet)
  }
  # Allow SSH access (port 22) for management
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "22"
    source_ips = [var.public_subnet_cidr] # Restrict SSH access to the Kubernetes cluster
  }
  # Allow Redis access (port 6379)
  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "6379"
    source_ips = [var.public_subnet_cidr] # Allow access only from Kubernetes cluster nodes
  }
  # Apply firewall to the Redis cache instance
  apply_to {
    label_selector = "role=redis"
  }
}
