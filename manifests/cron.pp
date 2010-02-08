class puppet::cron inherits puppet {
    require cron
    case $kernel {
        linux: { include puppet::cron::linux }
        openbsd: { include puppet::cron::openbsd }
    }
}
