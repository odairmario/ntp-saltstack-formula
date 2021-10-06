# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as ntp with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

ntp-config-file-file-managed:
  file.managed:
    - name: {{ ntp.config }}
    - source: {{ files_switch(['ntp.conf.jinja'],
                              lookup='ntp-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ ntp.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        ntp: {{ ntp | json }}
