@RSAAlert(oneInSeconds=0)

SELECT * FROM Event(
(event_cat_name.toLowerCase() IN ( 'attacks.access' )
AND direction IN ( 'inbound' )
AND device_class.toLowerCase() IN ( 'firewall' )
AND event_desc.toLowerCase() LIKE '%draytek%'
AND NOT ip_src = "201.218.64.0/24"
)).std:groupwin(ip_src).win:time_length_batch(300 sec, 5) GROUP BY ip_src HAVING COUNT(*) = 5;
