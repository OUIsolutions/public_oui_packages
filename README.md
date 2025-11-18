# Public OUI Packages

This is the official public repository for OUI Solutions packages. All public OUI projects can be installed from this repository using the [PushBlind package manager](https://github.com/OUIsolutions/PushBlind).

## Overview

The Public OUI Packages repository serves as a centralized location for distributing and managing OUI Solutions' open-source projects. This repository is designed to work seamlessly with the PushBlind package manager, providing an easy and efficient way to install and manage OUI tools and libraries.

## Installation

### Adding the Repository

To add this repository to your PushBlind package manager, execute the following command:

https:
```bash
pushblind add https://github.com/OUIsolutions/public_oui_packages.git all.lua --name public_oui
```
ssh: 
```bash
pushblind add git@github.com:OUIsolutions/public_oui_packages.git all.lua --name public_oui
```

### Installing Packages

After adding the repository, you can install any available package by following these steps:

1. Update the repository to get the latest package information:
   ```bash
   pushblind update public_oui
   ```

2. Install the desired package (using Darwin as an example):
   ```bash
   pushblind install darwin
   ```

## Available Projects

| Name                                                    | Description                   | Installation File                          | 
|---------------------------------------------------------|-------------------------------|-------------------------------------------|
|[vibescript](https://github.com/OUIsolutions/VibeScript) |a lua runtime for vibecoding   | [vibescript.lua](/vibescript.lua)         |
|[darwin](https://github.com/OUIsolutions/Darwin)         |A Boostrapped lua Compiler     | [darwin.lua](/darwin.lua)                 |

## Requirements

- [PushBlind package manager](https://github.com/OUIsolutions/PushBlind) must be installed and configured on your system

## Contributing

This repository is maintained by OUI Solutions. For issues, feature requests, or contributions related to individual projects, please visit the respective project repositories listed in the table above.

## License

Please refer to the LICENSE file in this repository and the individual project licenses for specific licensing information.

## Support

For support and questions regarding the package repository or PushBlind integration, please visit the [PushBlind repository](https://github.com/OUIsolutions/PushBlind) or contact OUI Solutions.


