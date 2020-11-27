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
         
         # CORS
         if ($request_method = 'OPTIONS') {
           add_header 'Access-Control-Allow-Origin' "${PROXY_ALLOW_ORIGIN:-*}";
           add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
           add_header 'Access-Control-Allow-Headers' 'Accept,Authorization,Cache-Control,Content-Type,DNT,If-Modified-Since,Keep-Alive,Origin,User-Agent,X-Mx-ReqToken,X-Requested-With';
           add_header 'Access-Control-Allow-Credentials' 'true';
           add_header 'Access-Control-Max-Age' 1728000;
           add_header 'Content-Type' 'text/plain; charset=utf-8';
           add_header 'Content-Length' 0;
           return 204;
        }
        if ($request_method = 'POST') {
           add_header 'Access-Control-Allow-Origin' "${PROXY_ALLOW_ORIGIN:-*}";
           add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
           add_header 'Access-Control-Allow-Headers' 'Accept,Authorization,Cache-Control,Content-Type,DNT,If-Modified-Since,Keep-Alive,Origin,User-Agent,X-Mx-ReqToken,X-Requested-With';
           add_header 'Access-Control-Allow-Credentials' 'true';
           add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range';
        }
        if ($request_method = 'GET') {
           add_header 'Access-Control-Allow-Origin' "${PROXY_ALLOW_ORIGIN:-*}";
           add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
           add_header 'Access-Control-Allow-Headers' 'Accept,Authorization,Cache-Control,Content-Type,DNT,If-Modified-Since,Keep-Alive,Origin,User-Agent,X-Mx-ReqToken,X-Requested-With';
           add_header 'Access-Control-Allow-Credentials' 'true';
           add_header 'Access-Control-Expose-Headers' 'Content-Length,Content-Range';
        }
       
       # Proxy path
       proxy_pass ${PROXY_PROTO:-https}://${PROXY_ADDRESS}; 
       proxy_set_header Authorization "Bearer ${PROXY_BEARER}";
       # add_header 'Access-Control-Allow-Origin' '*';
    }
}
EOF
