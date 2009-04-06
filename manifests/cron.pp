# manifests/cron.pp

class puppet::cron inherits puppet {
    include cron
    case $kernel {
        linux: { include puppet::cron::linux }
        openbsd: { include puppet::cron::openbsd }
        default: { include puppet::cron::base }
    }
}
