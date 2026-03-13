# Linux Firewall
Đây là hướng dẫn setup firewall trên `iptables` và `ip6tables`

## 1. Tải các package cần thiết
Tải package `iptables` và `iptables-persistent`
````
sudo apt install iptables iptables-persistent
````
> [!WARNING]
> Đối với `iptables-persistent`, server sẽ hỏi có setup các rule tự động hay không. <br>
> Bạn cần chọn `No` để tạo firewall mặc định

Sau khi tải xong, các `chain` sẽ ở trạng thái `ACCEPT`

## 2. Setup các rule trên chain
Do firewall đang định hướng setup để chặn bất kỳ kết nối nào ngoài các kết nối được cho phép. Bạn cần đặt các rule cho firewall duyệt.<br>
Setup sẽ thực hiện trên cả `iptables` và `ip6tables`

### 2.1 Setup cho các kết nối cần thiết
Để server có thể thực hiện các hoạt động cơ bản (ping ra bên ngoài, tải package, ...), bạn cần setup cho firewall cho phép.<br>
Các kết nối có trạng thái `ESTABLISHED`,`RELATED` sẽ được firewall cho phép.
````
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
````

### 2.2 Setup các dịch vụ chỉ cần mở cổng
Đối với các dịch vụ chỉ cần sử dụng cổng, bạn cần setup trên chain `INPUT`
````
sudo iptables -A INPUT -p <protocol> --dport <port> -j ACCEPT
sudo ip6tables -A INPUT -p <protocol> --dport <port> -j ACCEPT
````
Với:
+ `-p <protocol>`: Giao thức của dịch vụ sử dụng (TCP/UDP)
+ `--dport <port>`: Cổng cần sử dụng

### 2.3 Setup cho dịch vụ mDNS
Đối với dịch vụ mDNS qua `avahi-daemon`, bạn cần cho phép cổng `5353` và địa chỉ multicast với cùng cổng `5353`.
````
sudo iptables -A INPUT -p tcp --dport 5353 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 5353 -d 224.0.0.251 -j ACCEPT

sudo ip6tables -A INPUT -p tcp --dport 5353 -j ACCEPT
sudo ip6tables -A INPUT -p tcp --dport 5353 -d ff02::fb -j ACCEPT
````

## 3. Setup rule trên chain
Sau khi setup xong các rule, bạn cần chặn các kết nối ngoài rule trên chain `INPUT` và `FORWARD` về `DROP`.<br>
Chain `OUTPUT` không cần phải thay đổi
````
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP

sudo ip6tables -P INPUT DROP
sudo ip6tables -P FORWARD DROP
````

## 4. Lưu rule
Bạn cần lưu các rule để server có thể load trước khi sử dụng
````
sudo netfilter-persistent save
````
> [!TIP]
> Bạn có thể xem các rule trên termial
> ````
> sudo iptables -L
> sudo ip6tables -L
> ````

## 5. Hoàn thành
Vậy là bạn đã hoàn thành việc setup firewall.
Good luck.
