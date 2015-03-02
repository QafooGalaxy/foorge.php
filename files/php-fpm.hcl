template {
    source = "/opt/consul/php-fpm.ctmpl"
    destination = "/etc/php5/fpm/pool.d/env.conf"
    command = "reload php5-fpm || true"
}
