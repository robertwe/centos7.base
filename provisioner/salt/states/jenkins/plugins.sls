updates_dir:
  file.directory:
    - name: /var/lib/jenkins/updates
    - user: jenkins
    - group: jenkins

updates_defaults:
  cmd.run:
    - name: wget http://updates.jenkins-ci.org/update-center.json -qO- | sed '1d;$d'  > /var/lib/jenkins/updates/default.json
    - user: jenkins
    - group: jenkins
    - creates: jenkins/updates/default.json
    - require:
      - file: updates_dir

{% for plugin in salt['pillar.get']('jenkins_plugins') %}
install_plugin_{{ plugin }}:
  cmd.run:
    - name: java -jar /var/cache/jenkins/jenkins-cli.jar -s http://localhost:8080 install-plugin {{ plugin }}
    - creates: /var/lib/jenkins/plugins/{{ plugin }}.jpi
    - timeout: 60
    - require:
      - cmd: install_jenkis_cli
{% endfor %}
