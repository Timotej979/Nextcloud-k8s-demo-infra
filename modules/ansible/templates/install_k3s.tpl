---
- name: Install K3s Control Plane and Workers
  hosts: control_plane:workers
  become: yes
  vars:
    control_plane_ip: ${control_plane_ip}
  tasks:

    # Install K3s on Control Plane Nodes
    - name: Install K3s server on control plane nodes
      shell: |
        curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--disable servicelb --disable traefik --write-kubeconfig-mode 644" sh -
      args:
        creates: /usr/local/bin/k3s
      when: "'control_plane' in group_names"

    - name: Get K3s token from control plane
      shell: cat /var/lib/rancher/k3s/server/node-token
      register: k3s_token
      when: "'control_plane' in group_names"
      changed_when: false

    - name: Get control plane IP using Ansible facts
      set_fact:
        k3s_server_ip: "{{ ansible_host }}"
      when: "'control_plane' in group_names"

    # Pass K3s token and IP from control plane to workers
    - name: Set control plane token and IP for workers
      set_fact:
        k3s_server_token: "{{ hostvars[groups['control_plane'][0]].k3s_token.stdout }}"
        k3s_server_ip: "{{ hostvars[groups['control_plane'][0]].k3s_server_ip }}"
      when: "'workers' in group_names"

    # Ensure that control plane is ready
    - name: Wait for control plane K3s to be ready
      command: k3s kubectl get nodes
      register: result
      retries: 10
      delay: 15
      until: result.rc == 0
      when: "'control_plane' in group_names"

    # Fetch the kubeconfig file from the control plane
    - name: Fetch kubeconfig file from control plane
      fetch:
        src: /etc/rancher/k3s/k3s.yaml
        dest: ~/.kube/nextcloud_demo_kubeconfig
        flat: yes
      when: "'control_plane' in group_names"

    ############################################################################################################

    # Install K3s agent on Worker Nodes
    - name: Install K3s agent on worker nodes
      shell: |
        curl -sfL https://get.k3s.io | K3S_URL=https://{{ k3s_server_ip }}:6443 K3S_TOKEN={{ k3s_server_token }} K3S_NODE_LABELS="role=worker" sh -
      args:
        creates: /usr/local/bin/k3s-agent
      when: "'workers' in group_names"

    # Check K3s service status on worker nodes
    - name: Check K3s service status
      command: systemctl status k3s-agent
      register: k3s_service_status
      when: "'workers' in group_names"