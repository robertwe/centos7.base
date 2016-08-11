install_jenkins_server:
  pkg.installed:
    - name: jenkins
    - refresh: True

jenkins_sysconfig:
  file.managed:
    - name: /etc/sysconfig/jenkins
    - source: salt://jenkins/files/jenkins_sysconfig.j2
    - template: jinja
    - notify:
      - service: jenkins_serivce

jenkins_ssh_keys:
  file.recurse:
    - name: /var/lib/jenkins/.ssh
    - source: salt://jenkins/files/ssh
    - user: jenkins
    - group: jenkins
    - file_mode: 600

jenkins_init_scripts:
  file.recurse:
    - name: /var/lib/jenkins/init.groovy.d
    - source: salt://jenkins/files/init.groovy.d
    - user: jenkins
    - group: jenkins
    - watched_in:
      - cmd: restart_jenkins

jenkins_service:
  service.running:
    - name: jenkins
    - enable: True

restart_jenkins:
  cmd.wait:
    - name: java -jar /var/cache/jenkins/jenkins-cli.jar -s http://127.0.0.1:8080 safe-restart
