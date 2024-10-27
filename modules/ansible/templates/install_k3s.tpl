---
- name: Install K3s Control Plane and Workers
  hosts: control_plane:workers
  become: yes
  vars:
    k3s_version: ${k3s_version}
    cluster_cidr: ${cluster_cidr}
    control_plane_ip: ${control_plane_ip}
  tasks:
    - name: Update apt repo and cache on all Debian/Ubuntu boxes
      apt:
        update_cache: yes
        force_apt_get: yes
        cache_valid_time: 3600

    - name: Upgrade all packages on servers
      apt:
        upgrade: dist
        force_apt_get: yes

    # Install apparmor and apparmor-utils package
    - name: Install apparmor and apparmor-utils package
      apt:
        name: "{{ item }}"
        state: present
      loop:
        - apparmor
        - apparmor-utils

    # Install K3s on Control Plane Nodes
    - name: Install K3s server on control plane nodes
      shell: |
        curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION={{ k3s_version }} \
        INSTALL_K3S_EXEC="server \
        --disable-cloud-controller \
        --disable servicelb \
        --disable traefik \
        --disable local-storage \
        --disable metrics-server \
        --node-name=\"$(hostname -f)\" \
        --cluster-cidr={{ cluster_cidr }} \
        --etcd-expose-metrics=true \
        --node-taint CriticalAddonsOnly=true:NoExecute \
        --advertise-address={{ control_plane_ip }} \
        --node-ip={{ control_plane_ip }} \
        --node-external-ip={{ control_plane_ip }} \
        --write-kubeconfig-mode 644 \
        --cluster-init" sh -
      args:
        creates: /usr/local/bin/k3s
      when: "'control_plane' in group_names"

    # Ensure that control plane is ready
    - name: Wait for control plane K3s to be ready
      command: k3s kubectl get nodes
      register: result
      retries: 10
      delay: 15
      until: result.rc == 0
      when: "'control_plane' in group_names"

     # Get K3S token from the control plane
    - name: Get K3s token from the control plane
      command: cat /var/lib/rancher/k3s/server/node-token
      register: k3s_token
      when: "'control_plane' in group_names"

    # Save the token to local file
    - name: Fetch the K3S token file from the control plane
      fetch:
        src: /var/lib/rancher/k3s/server/node-token
        dest: ~/.kube/nextcloud_demo_k3s_token
        flat: yes
      when: "'control_plane' in group_names"

    # Fetch the kubeconfig file from the control plane
    - name: Fetch kubeconfig file from control plane
      fetch:
        src: /etc/rancher/k3s/k3s.yaml
        dest: ~/.kube/nextcloud_demo_kubeconfig
        flat: yes
      when: "'control_plane' in group_names"

    ############################################################################################################

    # Create the token file on the remote machine
    - name: Create the K3S token file on the remote machine
      shell: |
        mkdir -p /var/lib/rancher/k3s/server/
        touch /var/lib/rancher/k3s/server/node-token
      when: "'workers' in group_names"

    # Copy the local file to the worker nodes
    - name: Copy the K3S token file to the worker nodes
      copy:
        src: ~/.kube/nextcloud_demo_k3s_token
        dest: /var/lib/rancher/k3s/server/node-token
        force: yes
      when: "'workers' in group_names"

    # Extract the K3S token from the local file
    - name: Extract the K3S token from the local file
      shell: cat /var/lib/rancher/k3s/server/node-token
      register: k3s_token
      when: "'workers' in group_names"

    # Install K3s agent on Worker Nodes
    - name: Install K3s agent on worker nodes
      shell: |
        curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION={{ k3s_version }} K3S_URL=https://{{ control_plane_ip }}:6443 K3S_TOKEN={{ k3s_token.stdout }} K3S_NODE_LABELS="role=worker" sh -
      args:
        creates: /usr/local/bin/k3s-agent
      when: "'workers' in group_names"

    # Check K3s service status on worker nodes
    - name: Check K3s service status
      command: systemctl status k3s-agent
      register: k3s_service_status
      when: "'workers' in group_names"
