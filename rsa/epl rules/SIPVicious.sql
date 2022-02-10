@RSAAlert(oneInSeconds=0)
SELECT * FROM Event(
(event_desc.toLowerCase() LIKE '%sipvicious%'
AND ip_dstport IN ( 5060 ))).std:groupwin(event_desc).win:time_length_batch(300 sec, 5)
GROUP BY event_desc HAVING COUNT(*) = 5;
