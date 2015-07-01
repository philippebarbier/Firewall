#!/bin/sh 
 
# Réinitialise les règles
sudo iptables -t filter -F 
sudo iptables -t filter -X 
 
# Bloque tout le trafic
sudo iptables -t filter -P INPUT DROP 
sudo iptables -t filter -P FORWARD DROP 
sudo iptables -t filter -P OUTPUT DROP 
 
# Connexions localhost
sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT 
sudo iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT 
sudo iptables -t filter -A INPUT -i lo -j ACCEPT 
sudo iptables -t filter -A OUTPUT -o lo -j ACCEPT 
 
# Ping
sudo iptables -t filter -A INPUT -p icmp -j ACCEPT 
sudo iptables -t filter -A OUTPUT -p icmp -j ACCEPT 
 
# SSH
sudo iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT 
sudo iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT 
 
# HTTP
sudo iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT 
sudo iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT 

# FTP 
sudo iptables -t filter -A OUTPUT -p tcp --dport 20:21 -j ACCEPT 
sudo iptables -t filter -A INPUT -p tcp --dport 20:21 -j ACCEPT 

# Mail SMTP 
iptables -t filter -A INPUT -p tcp --dport 25 -j ACCEPT 
iptables -t filter -A OUTPUT -p tcp --dport 25 -j ACCEPT 
 
