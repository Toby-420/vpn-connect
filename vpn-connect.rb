#!/usr/bin/ruby

# SPDX-License-Identifier: GPL-3.0-or-later
# VPN connection utility.
# Copyright (C) 2026 Toby Valentine <tobyvalentine@member.fsf.org>
#
# This program is free software: you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the licenser, or (at your option) any later version.
#
# This program is distributred in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have recieved a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>.
#
# This is a utility to help connecting to wireguard VPNs defined in standard
# wireguard configuration files stored in /etc/wireguard/.
#
# Written in Ruby 3.4.7

puts " "
puts "VPN Connector Utility"
puts " "

# check if running as root
case (Process.uid)
when 0
  # we are as root
else
  $stderr.puts("Please run as root.")
  exit
end

args = ARGV

def dropConn ()
  currentConnection = `sudo wg | sed 's/ /\\n/g' | head -n 2 | tail -n 1`
  system ("wg-quick down /etc/wireguard/#{currentConnection.chomp}.conf")
end

if (args[0] == "d" or args[0] == "drop")
  if (`wg` == "")
    puts "No connection to drop."
    exit
  else
    while (`wg` != "")
      dropConn
    end
    exit
  end
elsif (args[0] == "s" or args[0] == "status")
  if (`wg` == "")
    puts "VPN not connected."
    exit
  end
  system ("sudo wg")
  exit
elsif (args[0] == "l" or args[0] == "list")
  availableConns = Dir.glob("/etc/wireguard/*")
  availableConns.each { |file| puts file[15..-6] if File.file?(file) }
  exit
elsif (ARGV.length == 0 or args[0] == "c" or args[0] == "connect")
  while (`wg` != "")
    dropConn
  end
  puts " "
  puts "Connecting to random server..."
  puts " "
  randomFile = Dir.glob("/etc/wireguard/*")
  if randomFile.empty?
    puts "No config files. Get them from your VPN provider."
  else
    randomFile = randomFile.sample
    system ("wg-quick up " + randomFile)
  end
  exit
else
  while (`wg` != "")
    dropConn
  end
  puts " "
  puts "Connecting to server in #{args[0]}"
  puts " "
  randomFile = Dir.glob("/etc/wireguard/#{args[0]}*")
  if randomFile.empty?
    puts "No files for " + args[0] + " found in /etc/wireguard/.\nGet them from your VPN provider"
  else
    randomFile = randomFile.sample
    system ("wg-quick up #{randomFile}")
  end
  exit
end

