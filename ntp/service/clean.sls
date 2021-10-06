# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as ntp with context %}

ntp-service-clean-service-dead:
  service.dead:
    - name: {{ ntp.service.name }}
    - enable: False
