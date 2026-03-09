# Apache Security
 ### + 1. Ẩn tên server tại `apache2.conf`
````
ServerTokens Prod
ServerSignature Off
````

 ### + 2. Setup Header
   + Cookies
````
Header edit Set-Cookie ^(.*)$ $1;HttpOnly;Secure
````
   +  X-Frame & XSS
````
$ sudo a2enmods headers

# Tại <VirtualHost>
Header always append X-Frame-Options SAMEORIGIN
Header set X-XSS-Protection "1; mode=block"     
````
 ### + 3. Ngăn chặn trace HTTP request tại `apache2.conf`
````
TraceEnable off
````
