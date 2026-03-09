# Setup LAMB 
Hướng dẫn về setup LAMP (Linux - Apache - MySQL - PHP)

## 1. Tải các package cần thiết
````
$ sudo apt install apache2 linapache2-mod-php php-mysql mysql-server
````

## 2. Setup PHP và Apache
Tại file `/etc/apache2/mods-enabled/dir.conf`
````
DirectoryIndex index.html index.cgi index.pl index.php index.xhtml
````
Đưa `index.php` lên trước
````
DirectoryIndex index.php index.html index.cgi index.pl index.xhtml
````

## 3. Kiểm nghiệm
Tạo file `index.php` tại `/var/www/html` để kiểm nghiệm
