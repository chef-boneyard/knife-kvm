# knife-kvm

Beta Version - supports Create, Delete and List for VMs

## Subcommands

### knife kvm vm create
| Name               | Default   | Description                  |
| ------------------ |:---------:| ----------------------------:|
| -h, --hostname     | required  | KVM hostname or IP           |
| -u, --username     | required  | KVM host username            |
| -p, --password     | required  | KVM host password            |
| --flavor           | required  | OS Flavor (ubuntu or el)     |
| --memory           | 1024 (MB) | memory in megabytes          |
| --iso-image        | required  | installation ISO filename    |
| --guest-ip         | required  | guest IP address             |
| --guest-gateway    | required  | guest gateway                |
| --guest-netmask    | required  | guest netmask                |
| --guest-nameserver | required  | guest nameserver             |
| --dhcp             | false     | use dhcp?                    |
| --disk-size        | 10 (GB)   | hard drive size in gigabytes |

#### Notes
- When using the `--dhcp` option, the `--guest-*` are not needed.
- The `--iso-image` argument assumes your ISOs are located in `/var/lib/libvirt/images/`
- The default root password for the created machine is `changeme` - the assumption is that you will be using Chef to manage your users.

### knife kvm vm delete
| Name               | Default   | Description                  |
| ------------------ |:---------:| ----------------------------:|
| -h, --hostname     | required  | KVM hostname or IP           |
| -u, --username     | required  | KVM host username            |
| -p, --password     | required  | KVM host password            |

### knife kvm vm list
| Name               | Default   | Description                  |
| ------------------ |:---------:| ----------------------------:|
| -h, --hostname     | required  | KVM hostname or IP           |
| -u, --username     | required  | KVM host username            |
| -p, --password     | required  | KVM host password            |

## Contributing

1. Fork it ( https://github.com/chef/knife-kvm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
Author:: Scott Hain <shain@chef.io>

Copyright:: Copyright (c) 2015 Chef Software, Inc.

License:: Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the
License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
either express or implied. See the License for the specific language governing permissions
and limitations under the License.
