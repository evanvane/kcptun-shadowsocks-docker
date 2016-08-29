# kcptun-shadowsocks-docker

#shadowsocks端口：shadowsocks 8989/tcp 8989/udp
#kcptun端口： 29900/udp


./client_linux_amd64 -l ":8888" -r "ip:29900" –mtu 1400 –sndwnd 2048 –rcvwnd 2048 -mode "fast2"
