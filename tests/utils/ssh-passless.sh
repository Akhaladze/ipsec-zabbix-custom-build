#!/bin/bash

ssh-keygen && ssh-copyid gnet@10.10.100.21


ZABBIX TOKEN
auth_token=$(curl -s -X POST -H "Content-Type: application/json"  -d '{ "jsonrpc": "2.0", "method": "user.login", "params": { "user": "Admin",  "password": "zabbix"}, "id": 2} 'http://localhost:8080/api_jsonrpc.php | jq -r '.result')
echo tt