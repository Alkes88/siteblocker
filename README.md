This script allows you to add or remove entries in your /etc/hosts-file for a given domain, directing both the domain.com and www.domain.com to 0.0.0.0. 
It also flushes the DNS cache and restarts the mDNSResponder to apply the changes immediately.

To add to the list:  ./siteblocker.sh "domain"

To remove from the list:  ./siteblocker.sh "domain" --remove
