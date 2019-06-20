# thethir13en_infra
thethir13en Infra repository

# single-command access to private IPs
* Create file ~/.ssh/config
* Paste configuration:
```
Host bastion
    Hostname 0.0.0.0(bastion host IP or dns-name)
    User test
    IdentityFile ~/path/to/private_key

Host private_host
    Hostname 0.0.0.0(private ip)
    User test
    IdentityFile ~/path/to/private_key
    ProxyJump bastion
```
