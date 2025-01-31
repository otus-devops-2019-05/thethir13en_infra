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

# add firewall rule from gcloud
```
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --source-tags=puma-server --source-ranges=0.0.0.0/0
```

# terraform
> Для добавления ключей в проект, необходимо описать данный ресурс и добавить ключи в метадату.
> Чтобы добавить несколько ключей, их необходимо написать друг-за-другом разделив знаками переноса строки '\n'.

* Пример :
```
resource "google_compute_project_metadata" "yourproject" {
  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)} \nappuser1:${file(var.public_key_path)}"
  }
}
```
> Балансировка нагрузки

При необходимости балансировки на несколько нод, можно использовать 2 подхода:

* Определять каждый инстанс, как отдельный ресурс(необходимо описывать каждый инстанс в коде, что неудобно)
* Указать количество инстансов в одном ресурсе (в данном случае мы можем определять одной переменной необходимое кол-во ресурсов)

> Удаленное хранение состояния

Для командной работы, над инфраструктурным проектом, всей команде необходимо иметь доступ к единому состоянию, чтобы избежать коллизий и несогласованности в изменениях. В Terraform это решается удаленным хранением состояния, которое может располагаться на сервере или в bucket(aws/gcp) и предоставляет единственный "источник правды" для всей команды.

* Пример настройки для GCP:
```
terraform {
  # required version
  required_version = ">= 0.11.7"
  backend "gcs" {
    bucket  = "mybucket-thirt13en"
    prefix  = "terraform/state"
  }
}
```

# Ansible

## Простой плейбук

После выполнения модуля command, директория с кодом, ранее созданная плейбуком успешно удалилась, так как была выполнена команда удаления этой директории. Вывод модуля:

```
appserver | SUCCESS | rc=0 >>
```
