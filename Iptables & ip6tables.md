# IPv4 & IPv6 Firewall rules
Các rule được thực hiện trên `iptables` và `ip6tables`
Các rule trên nhằm cho phép server hoạt động bình thường, cho phép các dịch vụ SSH, mDNS; và cho phép ping từ server ra bên ngoài 

### IPv4 firewall
````
# Xóa rules cũ
iptables -F
iptables -X

# Cho phép loopback
iptables -A INPUT -i lo -j ACCEPT

# Cho phép kết nối đã được thiết lập
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Avahi (mDNS)
iptables -A INPUT -p udp --dport 5353 -d 224.0.0.251 -j ACCEPT

# Cho phép ping từ ngoài vào (optional)
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# Cho phép server ping ra ngoài
iptables -A OUTPUT -p icmp -j ACCEPT

# Default policy
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
````

### IPv6 firewall
````
# Xóa rules cũ
ip6tables -F
ip6tables -X

# Loopback
ip6tables -A INPUT -i lo -j ACCEPT

# Kết nối đã thiết lập
ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# SSH
ip6tables -A INPUT -p tcp --dport 22 -j ACCEPT

# Avahi IPv6
ip6tables -A INPUT -p udp --dport 5353 -d ff02::fb -j ACCEPT

# Default policy
ip6tables -P INPUT DROP
ip6tables -P FORWARD DROP
ip6tables -P OUTPUT ACCEPT
# Ping IPv6
ip6tables -A INPUT -p icmpv6 -j ACCEPT
````
