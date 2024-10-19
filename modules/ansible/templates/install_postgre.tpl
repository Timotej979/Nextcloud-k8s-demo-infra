---
- name: Install PostgreSQL 14
  hosts: db_server
  become: yes  # Use sudo
  vars:
    public_subnet_cidr: ${public_subnet_cidr}
    postgresql_version: 14
    admin_password: ${admin_user_password}
    application_user: nextcloud
    application_password: ${nextcloud_password}
    application_db: nextcloud
  tasks:
    - name: Update apt cache
      apt: update_cache=yes
      
    - name: Install required Python packages
      apt:
        name:
          - python3-psycopg2
          - python3-pip
        state: present

    - name: Add the PostgreSQL APT key
      apt_key:
        url: https://www.postgresql.org/media/keys/ACCC4CF8.asc
        state: present

    - name: Add the PostgreSQL APT repositories
      apt_repository:
        repo: deb http://apt.postgresql.org/pub/repos/apt/ {{ ansible_distribution_release }}-pgdg main
        state: present

    - name: Update apt cache
      apt: update_cache=yes

    - name: Install PostgreSQL
      apt:
        name: postgresql-{{ postgresql_version }}
        state: present

    - name: Ensure PostgreSQL is listening on *
      lineinfile:
        dest: /etc/postgresql/14/main/postgresql.conf
        regexp: '^listen_addresses\s*='
        line: "listen_addresses='*'"
        state: present
      notify: Restart Postgresql

    - name: Add new configuration to "pg_hba.conf"
      blockinfile:
        dest: /etc/postgresql/14/main/pg_hba.conf
        block: |
          host    all             all             ${public_subnet_cidr}                scram-sha-256    
      notify: Restart Postgresql

    - name: Change default postgres user password
      become_user: postgres
      postgresql_user:
        name: postgres
        password: "{{ admin_password }}"  # Admin password provided in vars
        role_attr_flags: 'SUPERUSER'  # Ensure that the 'postgres' user retains superuser rights
        state: present

    - name: Create an application database user with limited privileges
      become_user: postgres
      postgresql_user:
        name: "{{ application_user }}"
        password: "{{ application_password }}"
        role_attr_flags: ''
        state: present    

    - name: Create an application database
      become_user: postgres
      postgresql_db:
        name: "{{ application_db }}"
        owner: "{{ application_user }}"
        state: present

    - name: Ensure the firewall allows traffic on port 5432 from public subnet
      ufw:
        rule: allow
        from_ip: '{{ public_subnet_cidr }}'
        to_port: 5432
        proto: tcp
      when: ansible_os_family == 'Debian'

  handlers:
    - name: Restart Postgresql
      systemd:
        name: postgresql
        state: restarted

    - name: Start Postgresql
      systemd:
        name: postgresql
        state: started

    - name: Stop Postgresql
      systemd:
        name: postgresql
        state: stopped

    - name: Enable Postgresql
      systemd:
        name: postgresql
        enabled: yes
