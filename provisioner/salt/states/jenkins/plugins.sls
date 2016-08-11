{% set jenkins_plugins = [
     "pipeline-stage-view",
     "ansicolor",
     "workflow-aggregator",
     "mask-passwords",
     "publish-over-ssh",
     "ssh-credentials",
     "scm-api",
     "tap",
     "jobConfigHistory",
     "configurationslicing",
     "swarm",
     "job-dsl",
     "envinject",
     "git",
     "bitbucket-oauth",
     "greenballs",
     "multiple-scms",
     "show-build-parameters",
     "subversion",
     "copyartifact",
     "cloudbees-credentials",
     "groovy",
     "git-parameter",
     "bitbucket-build-status-notifier",
     "bitbucket-pullrequest-builder",
     "rebuild",
     "promoted-builds",
     "parameterized-trigger",
     "plugin-usage-plugin",
     "discard-old-build" ]
%}

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

{% for plugin in jenkins_plugins %}
install_plugin_{{ plugin }}:
  cmd.run:
    - name: java -jar /var/cache/jenkins/jenkins-cli.jar -s http://127.0.0.1:8080 install-plugin {{ plugin }}
    - creates: /var/lib/jenkins/plugins/{{ plugin }}.jpi
    - timeout: 60
    - require:
      - cmd: install_jenkis_cli
{% endfor %}
