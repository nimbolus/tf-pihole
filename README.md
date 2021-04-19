# terraform module - pihole

Sets up a PiHole server instance on top of OpenStack.

## Request SSL Certificate with FreeIPA

Request a certificate as root user:
```sh
mkdir /etc/pihole/ssl
ipa-getcert request -K HTTP/$(hostname -f)@EXAMPLE.COM -k /etc/pihole/ssl/pihole.key -f /etc/pihole/ssl/pihole.crt -g 4096
cp /etc/ipa/ca.crt /etc/pihole/ssl/ca.crt
```

And add the following lines to `custom_config`:
```yaml
pihole_lighttpd_ssl: true
pihole_lighttpd_crt: /etc/pihole/ssl/pihole.crt
pihole_lighttpd_key: /etc/pihole/ssl/pihole.key
pihole_lighttpd_ca_crt: /etc/pihole/ssl/ca.crt
# add FreeIPA as resolver for managed domain (optional)
pihole_dnsmasq_custom_config: |
  no-hosts
  server=/ipa.example.com/10.0.0.10
```
