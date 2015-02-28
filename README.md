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

These are the default role variables:

    ---
    extensions: []
    dev_extensions: []
    ini_settings: 
      - { name: "date.timezone", value: "UTC" }
      - { name: "display_errors", value: "off" }
    dev_ini_settings:
      - { name: "display_errors", value: "on" }
    pools:
      - { name: "www", listen: "/var/run/php5-fpm.sock" }
    fpm_default_listen_mode: '600'
    fpm_default_user: 'www-data'
    fpm_default_group: 'www-data'
    fpm_default_pm: 'dynamic'
    fpm_default_pm_max_children: 5
    fpm_default_pm_start_servers: 2
    fpm_default_pm_min_spare_servers: 1
    fpm_default_pm_max_spare_servers: 3

Example Playbook
----------------

This role installs PHP using FPM for FastCGI and the CLI binary of PHP.

The minimal example:

    - hosts: app
      roles:
        - role: "qafoo.base"
        - role: "qafoo.php"

This defaults to using a single pool called "www" listening on unix socket
"/var/run/php5-fpm.sock" using all the FPM configuration that is used in Ubuntu
default FPM installation. It also sets the INI configuration `"date.timezone = UTC"`.

For every pool a log file with php errors will be placed under
`/var/log/php/{poolname}/error.log` and a logrotate script will be generated to
cleanup these log files.

A full example of all the possible development+pool related configuration options:

    - hosts: app
      roles:
        - role: "qafoo.base"
        - role: "qafoo.php"
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
            - name: "www3"
              options:
                - { name: "request_terminate_timeout": "30s"}
              env:
                - { name: "TMP", value: "/tmp"}
              php_admin_value:
                - { name: "sendmail_path", value: "/usr/sbin/sendmail -t -i -f www@my.domain.com" }
                - { name: "error_log", value: "/var/log/fpm-php.www.log" }
                - { name: "memory_limit", value: "32M" }
              php_admin_flag:
                - { name: "log_errors", value: "on" }
              php_flag:
                - { name: "display_errors", value: "off" }

License
-------

BSD

Author Information
------------------

Benjamin Eberlei <benjamin@qafoo.com>
https://github.com/QafooGalaxy
