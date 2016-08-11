create_dir_for_swarm:
  file.directory:
    - name: /var/lib/jenkins/swarm
    - user: {{ salt['pillar.get']('jenkins_user') }}
    - group: {{ salt['pillar.get']('jenkins_group') }}

swarm_client:
  file.managed:
    - name: /var/lib/jenkins/swarm/swarm-client.jar
    - source: {{ salt['pillar.get']('swarm_client_url') }}
    - source_hash: {{ salt['pillar.get']('swarm_hash_url') }}
    - user: {{ salt['pillar.get']('jenkins_user') }}
    - group: {{ salt['pillar.get']('jenkins_group') }}

swarm_systemd:
  file.managed:
    - name: /etc/systemd/system/jenkins-client.service
    - source: salt://jenkins/files/jenkins-client.systemd.j2
    - template: jinja


jenkin_slave_service:
  service.running:
    - name: jenkins-client
    - enable: True
    - watch:
      - file: swarm_systemd
