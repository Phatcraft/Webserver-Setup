echo "Setting up firewall. Please wait..."

# Reseting firewall
printf "Reset firewall: "
# IPv4
sudo iptables -F
sudo iptables -X

# IPv6
sudo ip6tables -F
sudo ip6tables -X
echo "OK"

printf "Reset rule chain: "
# Setting up rule chain
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD ACCEPT

sudo ip6tables -P INPUT ACCEPT
sudo ip6tables -P OUTPUT ACCEPT
sudo ip6tables -P FORWARD ACCEPT
echo "OK"

printf "Setting up IPv4 firewall: "
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p udp --dport 5353 -j ACCEPT
echo "OK"

printf "Setting up IPv6 firewall: "
sudo ip6tables -A INPUT -i lo -j ACCEPT
sudo ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo ip6tables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo ip6tables -A INPUT -p udp --dport 5353 -j ACCEPT
echo "OK"

printf "Setting up rule chain: "
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo ip6tables -P INPUT DROP
sudo ip6tables -P FORWARD DROP
echo "OK"

printf "Saving rules: "
sudo netfilter-persistent save
echo "OK"
echo ""
