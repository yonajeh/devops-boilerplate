docker run --rm \
-v /root/nginx/certs/www:/var/www/certbot \
-v /root/nginx/certs:/etc/letsencrypt \
certbot/certbot certonly --webroot \
--webroot-path=/var/www/certbot \
--email yonajehlux@gmail.com \
--agree-tos \
--no-eff-email \
-d craftmanpro.online
