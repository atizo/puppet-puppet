# This class sets up the necessary ActiveRecord bits
# so storeconfigs works.
class puppet::storeconfigs inherits puppet::server {
    include rails
}
