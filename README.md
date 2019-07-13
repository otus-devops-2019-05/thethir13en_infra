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
# vpn test info
bastion_IP = 35.210.251.102
someinternalhost_IP = 10.132.0.3

#testapp info
testapp_IP = 35.195.78.188
testapp_port = 9292

# provisioning instance with startup script
```
gcloud compute instances create reddit-app-3 `
  --boot-disk-size=10GB `
  --image-family ubuntu-1604-lts `
  --image-project=ubuntu-os-cloud `
  --machine-type=g1-small `
  --tags puma-server `
  --restart-on-failure `
  --metadata-from-file startup-script=startup_script.sh
```
