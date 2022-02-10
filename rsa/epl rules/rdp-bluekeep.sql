@RSAAlert(oneInSeconds=0)
SELECT * FROM Event(
(direction.toLowerCase() LIKE '%inbound%'
AND ip_dstport IN ( 3389 ))).std:groupwin(ip_src).win:time_length_batch(300 sec, 10)
GROUP BY ip_src HAVING COUNT(*) = 10;
