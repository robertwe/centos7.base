create_seed_job_dir:
  file.directory:
    - name: /var/lib/jenkins/jobs/seed
    - user: jenkins
    - group: jenkins
    - makedirs: True
    - require:
      - pkg: install_jenkins_server

create_seed_workspace_dir:
  file.directory:
    - name: /var/lib/jenkins/jobs/seed/workspace
    - user: jenkins
    - group: jenkins
    - makedirs: True
    - require:
      - pkg: install_jenkins_server

upload_seed_job_config:
  file.managed:
    - name: /var/lib/jenkins/jobs/seed/config.xml
    - source: salt://jenkins/files/jobs/seed/config.xml
    - user: jenkins
    - group: jenkins
    - require:
      - file: create_seed_job_dir
      - sls: jenkins.plugins
    - watch_in:
      - cmd: restart_jenkins

