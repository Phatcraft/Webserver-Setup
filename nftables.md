# `nftables` Firewall
Đây là setup nftables cho server hoạt động bình thường cùng với các dịch vụ cơ bản (SSH, mDNS, Samba)

## 1. Tải các package cần thiết
Bạn cần tải package `nftables` để setup firewall
````
sudo apt install nftables
````

## 2. Setup `/etc/nftables.conf`
Sau khi tải package, bạn có thể setup tại file `/etc/nftables` (file được tạo tự động).<br>
*File tham khảo*
````
#!/usr/sbin/nft -f

flush ruleset

table inet filter {
	chain input {
		type filter hook input priority filter;
		policy drop;

		iif lo counter accept											# Loopback
		ct state established,related counter accept						# Established, related connections
		icmpv6 type {nd-router-advert, echo-reply} counter accept		# IPv6

		tcp dport 22 counter accept						# SSH
		udp dport 5353 counter accept					# mDNS
		tcp dport 445 counter accept					# Samba
	}
	chain forward {
		type filter hook forward priority filter;
		policy drop;
	}
	chain output {
		type filter hook output priority filter;
		policy accept;
	}
}
````

Hướng dẫn cụ thể: 
+ `chain input`: các hướng đi ra/vào firewall (`input`, `output`, `forward`)
+ `policy accept/drop`: Rule cho các kết nối ra/vào firewall (trừ các rule đã set)
+ `iif lo counter accept`: Setup chấp nhận cho `lo` interface
+ `ct state established,related counter accept`: Setup chấp nhận các kết nối loại `established`,`related`
+ `icmpv6 type nd-router-advert counter accept`: Setup chấp nhận `ICMPv6` loại `nd-router-advert` (nhằm setup IPv6)
+ `<protocol> dport <port> counter accept`: Setup chấp nhận các dịch vụ dùng cổng `<port>` và protocol `<protocol>`(TCP/UDP)

> [!TIP]
> Setup này đều áp dụng cho cả IPv4 và IPv6

## 3. Xem hoạt động của firewall
Do có đặt tham số `counter`, nên chúng ta có thể xem số gói tin đã qua firewall
````
sudo nft list chain inet filter input
````

## 4. Hoàn thành
Vậy là bạn đã hoàn thành setup `nftables` cho server.<br>
Good luck!!
