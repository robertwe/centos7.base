wait_for_jenkins:
  cmd.run:
    - name: until curl -sI  http://127.0.0.1:8080 |grep '200 OK'; do sleep 5; done
    - creates: /var/cache/jenkins/jenkins-cli.jar
    - timeout: 60
    - require:
      - service: jenkins

install_jenkis_cli:
  cmd.run:
    - name: wget -q -O /var/cache/jenkins/jenkins-cli.jar http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar
    - creates: /var/cache/jenkins/jenkins-cli.jar
    - user: jenkins
    - group: jenkins
    - onchanges:
      - cmd: wait_for_jenkins
