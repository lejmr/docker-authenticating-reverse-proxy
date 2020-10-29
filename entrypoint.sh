#!/bin/sh


cat << EOF > /etc/nginx/conf.d/default.conf
server {
    listen       80;
    server_name  localhost;

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    location / {
       proxy_pass ${PROXY_PROTO:-https}://${PROXY_ADDRESS}; 
       proxy_set_header Authorization "Bearer ${PROXY_BEARER}";
       add_header 'Access-Control-Allow-Origin' '*';
    }
}
EOF
