# Setup NGINX cơ bản

## + Setup server
````
# Server config
server_tokens off;
etag off;
autoindex off;
````

## + Setup Header
Setup header tại default site
````
# Headers
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "strict-origin-when-cross-origin" always;
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;

add_header Content-Security-Policy "
    default-src 'self';
    img-src 'self' data:;
    script-src 'self' 'unsafe-inline';
    style-src 'self' 'unsafe-inline';
    font-src 'self' data:;
    object-src 'none';
    base-uri 'self';
    frame-ancestors 'self';
" always;

add_header Permissions-Policy "geolocation=(), microphone=(), camera=()" always;
````

## + Setup giới hạn các method có thể thực hiện
Setup ngăn chặn các method ngoài `GET`, `POST`, `HEAD` trong nginx config
````
location / {
    limit_except GET POST HEAD {
        deny all;
    }
}
````
