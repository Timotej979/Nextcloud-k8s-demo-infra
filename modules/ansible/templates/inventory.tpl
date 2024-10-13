[db]
${db_ip} ansible_user=root ansible_ssh_private_key_file=${db_ssh_key_name} ansible_ssh_pass=${db_ssh_key_password}

[redis]
${redis_ip} ansible_user=root ansible_ssh_private_key_file=${redis_ssh_key_name} ansible_ssh_pass=${redis_ssh_key_password}

[control_plane]
%{ for ip in control_plane_ips }
${ip} ansible_user=root ansible_ssh_private_key_file=${control_plane_ssh_key_name} ansible_ssh_pass=${control_plane_ssh_key_password}
%{ endfor }

[workers]
%{ for ip in worker_ips }
${ip} ansible_user=root ansible_ssh_private_key_file=${worker_ssh_key_name} ansible_ssh_pass=${worker_ssh_key_password}
%{ endfor }
