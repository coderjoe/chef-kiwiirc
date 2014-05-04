# kiwiirc cookbook

[![Build Status](https://travis-ci.org/coderjoe/chef-kiwiirc.svg?branch=master)](https://travis-ci.org/coderjoe/chef-kiwiirc)

A cookbook designed to build and install kiwiirc from the official git repository.

## Supported Platforms

This cookbook has only tested under:
 - Ubuntu 12.04
 - Debian 7.4

It may work on other Unix like operating systems, but your mileage may differ.

## Attributes

| Key                             | Type    | Default                           | Description                                               |
|---------------------------------|---------|-----------------------------------|-----------------------------------------------------------|
| ['kiwiirc']['user']             | String  | "kiwiirc"                         | The user under which KiwiIRC will be installed and run    |
| ['kiwiirc']['group']            | String  | "kiwiirc"                         | The group under which KiwiIRC will be installed and run   |
| ['kiwiirc']['directory']        | String  | "/home/kiwiirc"                   | The install directory                                     |
| ['kiwiirc']['git']['uri']       | String  | github.com/prawnsalad/KiwiIRC.git | The URI to git repository to clone                        |
| ['kiwiirc']['git']['revision']  | String  | v0.8.3                            | The revision to install                                   |

## Usage

If you'd like to install both ratbox and ratbox-services you can use the default recipe.

Include `kiwiirc` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[kiwiirc::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change
5. Run the tests, ensuring they all pass in both ruby 1.9.3 and 2.0.0
6. Submit a Pull Request

## License and Authors

Author:: Joseph Bauser (coderjoe@coderjoe.net)
