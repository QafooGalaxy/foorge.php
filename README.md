Qafoo PHP
=========

Ubuntu PHP Role (using apt-get not sources).

Install all the necessary requirements to run a PHP application server
using FastCGI (via PHP-FPM).

Requirements
------------

Ubuntu Server

Role Variables
--------------

    extensions: []
    dev_extensions: []
    ini_settings: {}
    dev_ini_settings: {}
    pools: []

Example Playbook
----------------

This role installs PHP using FPM for FastCGI and the CLI binary of PHP.

    - hosts: app
      roles:
        - role: qafoo-base
        - role: qafoo-php
          extensions:
            - php5-gd
            - php5-imagick
          dev_extensions:
            - php5-xdebug
          ini_settings:
            - { name : "date.timezone", value: "UTC" }
          dev_ini_settings:
            - { name : "xdebug.enable", value: "1" }
          pools:
            - { name: "www" } # defaults to /var/run/php5-fpm-www.sock
            - { name: "www2", user: "not-www-data", pm: "static", pm_max_children: 200, listen: "127.0.0.1:9000" }
            - {
                name: "www3",
                options: {"request_terminate_timeout": "30s"},
                env: {"TMP": "/tmp"},
                php_admin_value:
                    "sendmail_path": "/usr/sbin/sendmail -t -i -f www@my.domain.com",
                    "error_log": "/var/log/fpm-php.www.log"
                    "memory_limit": "32M"
                php_admin_flag:
                    "log_errors": "on"
                php_flag:
                    "display_errors": "off"
              }

License
-------

BSD

Author Information
------------------

Benjamin Eberlei <benjamin@qafoo.com>
https://github.com/QafooGalaxy
