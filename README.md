# terraform module - pihole

Sets up a PiHole server instance on top of OpenStack.

## Request SSL Certificate with FreeIPA

Request a certificate as root user:
```sh
ipa-getcert request -K HTTP/$(hostname -f)@EXAMPLE.COM -k /etc/ssl/private/pihole.key -f /etc/ssl/certs/pihole.crt -g 4096
```

And add the following lines to `custom_config`:
```yaml
pihole_lighttpd_ssl: true
pihole_lighttpd_crt: /etc/ssl/certs/pihole.crt
pihole_lighttpd_key: /etc/ssl/private/pihole.key
pihole_lighttpd_ca_crt: /etc/ipa/ca.crt
```
