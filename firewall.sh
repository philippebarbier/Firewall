#!/bin/sh 
 
# Réinitialise les règles
iptables -t filter -F 
iptables -t filter -X 
 
# Bloque tout le trafic
iptables -t filter -P INPUT DROP 
iptables -t filter -P FORWARD DROP 
iptables -t filter -P OUTPUT DROP 
 
# Connexions localhost
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT 
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT 
iptables -t filter -A INPUT -i lo -j ACCEPT 
iptables -t filter -A OUTPUT -o lo -j ACCEPT 

# Ping
iptables -t filter -A INPUT -p icmp -j ACCEPT 
iptables -t filter -A OUTPUT -p icmp -j ACCEPT 
 
# SSH
iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT 
iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT 
 
# HTTP
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT 
iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT 

# FTP 
iptables -t filter -A OUTPUT -p tcp --dport 20:21 -j ACCEPT 
iptables -t filter -A INPUT -p tcp --dport 20:21 -j ACCEPT 

# Mail SMTP 
iptables -t filter -A INPUT -p tcp --dport 25 -j ACCEPT 
iptables -t filter -A OUTPUT -p tcp --dport 25 -j ACCEPT 

# DNS
iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT 
iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT 
iptables -t filter -A INPUT -p tcp --dport 53 -j ACCEPT 
iptables -t filter -A INPUT -p udp --dport 53 -j ACCEPT 
