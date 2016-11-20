# Puppet Server Docker image

Run:

```
docker run -d -p 8140:8140 --name puppet-server -v /puppet/code:/etc/puppetlabs/code/ stefanprodan/dockpuppet
```

Specs:
 - Ubuntu 14.04
 - Puppet Server 2.4.0
 - Puppet 4.8.0
 - Ruby 2.1.9p490
 - Ruby gem 2.2.5
 