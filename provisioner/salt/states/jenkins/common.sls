{% set jenkins_user  = salt['pillar.get']('jenkins_user') %}
{% set jenkins_group = salt['pillar.get']('jenkins_group') %}
{% set jenkins_home  = salt['pillar.get']('jenkins_home') %}

jenkins_group:
  group.present:
    - name: jenkins
    - system: True

jenkins_user:
  file.directory:
    - name: /var/lib/jenkins
    - user: jenkins
    - group: jenkins
    - mode: 0755
    - require:
      - user: jenkins_user
      - group: jenkins_group
  user.present:
    - name: jenkins
    - groups:
      - jenkins
    - system: True
    - home: /var/lib/jenkins
    - shell: /bin/bash
    - require:
      - group: jenkins_group

jenkins:
  pkgrepo.managed:
    - humanname: Jenkins Repo
    - baseurl: http://pkg.jenkins-ci.org/redhat
    - gpgkey: http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
    - require_in:
      - pkg: jenkins

jenkins_packages:
  pkg.installed:
    - pkgs:
      - curl
      - wget
      - mc
      - nano
      - sudo
      - screen
      - java-1.8.0-openjdk
