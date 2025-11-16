# vpn-connect
## A simple script to automatically connect to a vpn using wireguard config files.
Put your wireguard configuration files in /etc/wireguard/
These files can have whatever descriptive name you want, just remember that name will show up in the network menu.
I recommend adding the following to your bashrc:

`alias vpn='sudo vpn-connect'`

since you don't have to type out the whole thing every time!
The example usage below will reflect using that terminology.

Setup:

Just put this file in /usr/bin/

Usage:

`vpn`       -  connects using a random file in /etc/wireguard

`vpn XX`    -  connects to a random file starting with XX (useful if yours start with country codes)

`vpn d`     -  disconnect from all connected vpns (also works if you accidentally connected to 2 at once) 

Hopefully you find this script useful!
