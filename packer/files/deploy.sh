#!/bin/bash
set -e

# Deploy application
mkdir /srv/puma
cd /srv/puma && git clone -b monolith https://github.com/express42/reddit.git .
cd /srv/puma/ && bundle install

# Enable application at startup
systemctl enable puma.service
