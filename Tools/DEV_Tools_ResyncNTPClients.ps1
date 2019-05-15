w32tm /config /syncfromflags:domhier /update
w32tm /resync /rediscover
Restart-Service W32Time