template {
    source = "/opt/consul/php-fpm.ctmpl"
    destination = "/etc/php5/fpm/pool.d/env.conf"
    command = "restart php5-fpm || true"
}
