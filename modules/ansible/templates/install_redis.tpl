---
- name: Install and set up Redis 6 in Ubuntu 20.04
  hosts: redis_server
  become: yes
  gather_facts: False
  vars:
    public_subnet_cidr: ${public_subnet_cidr}
    redis_user: nextcloud
    redis_password: ${redis_password}
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

    - name: Set up Redis 6 repo
      shell: |
        curl https://packages.redis.io/gpg | sudo apt-key add -
        echo "deb https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list        

    - name: Install redis
      apt:
        name: redis
        update_cache: yes
      notify:
        - Enable Redis

    - name: Set redis server pid file
      lineinfile:
        path: /etc/redis/redis.conf
        regexp: "^pidfile"
        line: "pidfile /var/run/redis/redis-server.pid"
      notify:
        - Restart Redis

    - name: Secure redis with a password
      lineinfile:
        dest: /etc/redis/redis.conf
        regexp: '^(# )?requirepass \w*$'
        line: "requirepass {{ redis_password }}"
        state: present
      notify:
        - Restart Redis

    - name: Bind redis to all IPs
      lineinfile:
        dest: /etc/redis/redis.conf
        regexp: '^bind \b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b$'
        line: "bind 0.0.0.0"
        state: present
      notify:
        - Restart Redis

    - name: Ensure the firewall allows traffic on port 6379 from public subnet
      ufw:
        rule: allow
        from_ip: "{{ public_subnet_cidr }}"
        port: '6379'
        proto: tcp

    - name: Deny all other connections on Redis port 6379 (UFW)
      ufw:
        rule: deny
        port: '6379'
        proto: tcp

  handlers:
    - name: Restart Redis
      systemd:
        name: redis-server
        state: restarted

    - name: Start Redis
      systemd:
        name: redis-server
        state: started

    - name: Stop Redis
      systemd:
        name: redis-server
        state: stopped

    - name: Enable Redis
      systemd:
        name: redis-server
        enabled: yes
