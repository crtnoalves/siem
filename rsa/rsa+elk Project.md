# Project integration RSA + ELK
- https://community.rsa.com/community/products/netwitness/blog/2019/03/11/netwitness-packet-meta-in-elk

```
yum install python2
pip install urllib3 requests
pip install requests
```
- wget https://community.rsa.com/servlet/JiveServlet/download/2823-1-61016/mappings.json.zip
- wget https://community.rsa.com/servlet/JiveServlet/download/2823-1-61015/nwsdk_json.py.zip

## input
```
input {
  exec {
    command => "/usr/bin/python2.7 /usr/share/logstash/modules/nwsdk_json.py -c http://10.101.13.1:50103 -k '*' -w 'service exists' --user=admin --pass=netwitness"
    interval => 5
    #schedule => "1 * * * *"
    type => 'netwitness'
    codec => 'json_lines'
  }
}

filter {
   mutate {
      remove_field => ["command"]
   }
}

output {
  elasticsearch {
    hosts => ["http://localhost:9200"]
    index => "netwitness-%{+YYYY.MM.dd}"
  }
}
```