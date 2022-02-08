#!/bin/bash
IFS=$'\n'
for i in `echo 'db.latestSyncSnapshot.find().toArray()' | mongo sa -u deploy_admin -p password --authenticationDatabase admin | grep "\"name\"" | awk -F':' '{print $2}' | awk -F'"' '{print $2}'`
do
echo "Deployment Name \"$i\" contains the following rule IDs with Friendly Name"
for j in `echo 'db.latestSyncSnapshot.find({"name" : "'"$i"'"}).toArray()' | mongo sa -u deploy_admin -p password --authenticationDatabase admin | grep "\"ruleId\""`
do
echo $j
for r in `echo $j | awk -F'"' '{print $4}'`
do
# echo $r
echo 'db.rule.find({"_id" : "'"$r"'"}, {"parameters.name" : 0}).toArray()' | mongo sa -u deploy_admin -p password --authenticationDatabase admin | grep "\"name\""
echo 'db.rule.find({"_id" : ObjectId("'"$r"'")}, {"parameters.name" : 0, "statements.name" : 0}).toArray()' | mongo sa -u deploy_admin -p password --authenticationDatabase admin | grep "\"name\""
echo ""
echo ""
done
done
done