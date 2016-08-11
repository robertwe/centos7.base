{% if not salt['pillar.get']('jenkins_users') == "" %}
{% for users, user in salt['pillar.get']('jenkins_users').items() %}

{{ users }}:
  file.directory:
    - name: /var/lib/jenkins/users/{{ users }}
    - user: jenkins
    - group: jenkins

{{ users }}_config:
  file.managed:
    - name: /var/lib/jenkins/users/{{ users }}/config.xml
    - source: salt://jenkins/files/user_config.xml.j2
    - template: jinja
    - user: jenkins
    - group: jenkins
    - context:
      juser: {{ user }}

{% endfor %}
{%  endif %}
