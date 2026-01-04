# vpn-connect
## A simple script to automatically connect to a vpn using wireguard config files.
Put your wireguard configuration files in /etc/wireguard/

These files can have whatever descriptive name you want, just remember that it will show up in the network menu and is used for connecting.

I recommend adding something like this to your bashrc:

`alias vpn='sudo vpn-connect.rb'`

since you don't have to type out the whole thing every time!

The example usage below will reflect using that terminology.

### Setup:

Just put whichever file you want in /usr/bin/

### Prerequisites

Since it uses wireguard, you'll need [wireguard-tools](https://github.com/WireGuard/wireguard-tools).

vpn-connect is just a bash script so you just need bash.

I recommend using vpn-connect.rb though since it doesn't parse ls. You'll just need [Ruby](https://ruby-lang.org) for this.

### Usage:

`vpn / vpn c / vpn connect`       - connects using a random file in /etc/wireguard.

`vpn X`                           - connects to a random file starting with X (useful if yours start with country codes or other descriptive things).
                                        Not limited to 1 character. 

`vpn d / vpn drop`                - disconnect from all connected vpns (also works if you accidentally connected to 2 at once).

`vpn s / vpn status`              - status of current VPN connection. Currently just outputs sudo wg, this will be changed in the future to be more informative.

`vpn l / vpn list`                - lists all available configurations you can use
Hopefully you find this script useful!
