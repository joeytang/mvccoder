hibernate.dialect=org.hibernate.dialect.MySQLDialect

# Database login information
jdbc.username=${db.userName}
jdbc.password=${db.password}
jdbc.url=jdbc:mysql://${db.url}/${db.name}?characterEncoding=utf-8

jdbc.driverClassName=${db.driver}

# Time to wait for an open connection before timing out
# (in milliseconds)
cpool.checkoutTimeout=5000

cpool.autoCommitOnClose = true

# Connection pool size
cpool.minPoolSize=1
cpool.maxPoolSize=64

# How long to keep unused connections around(in seconds)
# Note: MySQL times out idle connections after 8 hours(28,800 seconds)
# so ensure this value is below MySQL idle timeout
cpool.maxIdleTime=25200

# How long to hang on to excess unused connections after traffic spike
# (in seconds)
cpool.maxIdleTimeExcessConnections=1200

# Acquiring new connections is slow, so eagerly retrieve extra connections
# when current pool size is reached
cpool.acquireIncrement=5
