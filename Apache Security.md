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
Header always set X-Frame-Options "SAMEORIGIN"
Header always set X-Content-Type-Options "nosniff"
Header always set X-XSS-Protection "1; mode=block"
Header always set Referrer-Policy "strict-origin-when-cross-origin"

Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"

Header always set Content-Security-Policy "default-src 'self'; img-src 'self' data:; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; font-src 'self' data:; object-src 'none'; base-uri 'self'; frame-ancestors 'self';"

Header always set Permissions-Policy "geolocation=(), microphone=(), camera=()"   
````
 ### + 3. Ngăn chặn trace HTTP request tại `apache2.conf`
````
TraceEnable off
````
