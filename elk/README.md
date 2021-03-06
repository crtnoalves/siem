# ELK Tips
## Check indices
curl 'http://localhost:9200/_cat/indices?v' | sort -k2

## Check health
curl -XGET http://localhost:9200/_cluster/health?pretty
***API

GET /_cluster/health?pre 

****************************************

## Check STARTED /UNASSIGNED
curl -XGET http://localhost:9200/_cat/shards
**API
GET /_cat/shards

****************************************

## Change status for green
curl -XPUT "http://127.0.0.1:9200/antispam-2019.*/_settings" -H 'Content-Type: application/json' -d' { "index" : { "number_of_replicas" : 0}}'
curl -XPUT "http://127.0.0.1:9200/$i/_settings" -H 'Content-Type: application/json' -d' { "index" : { "number_of_replicas" : 0}}'

****************************************

## Delete old indices:
curl -XDELETE http://localhost:9200/logstash-2018.xx.xx
***API
GET /_cat/indices?
DELETE logstash-2019.*

****************************************

## Dev Tools

```
POST logstash-2018.12.31/_delete_by_query
{
  "query": {
    "match": {
      "eventlog.category": "Kerberos Service Ticket Operations"
    }
  }
}
```
****************************************

# Change limite Maping

```
curl -XPUT 'localhost:9200/_settings' -H 'Content-Type: application/json' -d'
{
"index" : {
"mapping" : {
"total_fields" : {
"limit" : "100000" } } } }'
```
****************************************

# Change limte breaker

```
curl -X PUT "localhost:9200/_cluster/settings" -H 'Content-Type: application/json' -d'
{
     "transient" : {
         "indices.breaker.total.limit" : "97%"
     }
}
```
****************************************