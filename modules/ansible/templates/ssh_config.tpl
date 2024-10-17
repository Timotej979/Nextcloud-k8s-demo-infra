%{ for control_plane_ip in control_plane_ips }
Host control_plane
  User root
  HostName ${control_plane_ip}
  IdentityFile ${control_plane_ssh_key_path}
  ForwardAgent yes
%{ endfor }

%{ for worker_ip in worker_ips }
Host workers
  HostName ${worker_ip}
  User root
  IdentityFile ${worker_ssh_key_path}
  StrictHostKeyChecking no
%{ endfor }

Host db_server
  ProxyJump control_plane
  User root
  HostName ${db_ip}
  IdentityFile ${db_ssh_key_path}
  StrictHostKeyChecking no

Host redis_server
  ProxyJump control_plane
  User root
  HostName ${redis_ip}
  IdentityFile ${redis_ssh_key_path}
  StrictHostKeyChecking no