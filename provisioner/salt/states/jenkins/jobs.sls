{% for job in salt['pillar.get']('jenkins_jobs') %}

create_{{ job }}_job_dir:
  file.directory:
    - name: {{ salt['pillar.get']('jenkins_home') }}/jobs/{{ job }}
    - user: {{ salt['pillar.get']('jenkins_user') }}
    - group: {{ salt['pillar.get']('jenkins_group') }}
    - makedirs: True
    - require:
      - pkg: install_jenkins_server

upload_{{ job }}_job_config:
  file.managed:
    - name: {{ salt['pillar.get']('jenkins_home') }}/jobs/{{ job }}/config.xml
    - source: salt://jenkins/files/jobs/{{ job }}.xml
    - user: {{ salt['pillar.get']('jenkins_user') }}
    - group: {{ salt['pillar.get']('jenkins_group') }}
    - require:
      - file: create_{{ job }}_job_dir
      - sls: jenkins.plugins
    - watch_in:
      - cmd: restart_jenkins

{% endfor %}
