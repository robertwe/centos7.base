wait_for_jenkins:
  cmd.run:
    - name: until curl -sI  http://localhost:8080 |grep '200 OK'; do sleep 5; done
    - creates: {{ salt['pillar.get']('jenkins_cli') }}
    - timeout: 60
    - require:
      - service: jenkins

install_jenkis_cli:
  cmd.run:
    - name: wget -q -O {{ salt['pillar.get']('jenkins_cli') }} http://localhost:8080/jnlpJars/jenkins-cli.jar
    - creates: {{ salt['pillar.get']('jenkins_cli') }}
    - user: {{ salt['pillar.get']('jenkins_user') }}
    - group: {{ salt['pillar.get']('jenkins_group') }}
    - onchanges:
      - cmd: wait_for_jenkins
