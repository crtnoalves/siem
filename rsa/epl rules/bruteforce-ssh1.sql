@RSAAlert(oneInSeconds=0, identifiers={"ip_src"})
SELECT * FROM Event(
  (
    medium = 1 AND tcp_dstport = 22
    AND ip_src NOT REGEXP "200\.251\.129\.[0-9]{1,3}"
  )).std:groupwin(ip_src).win:time_length_batch(300 sec, 30) GROUP BY ip_src HAVING COUNT(*) = 30;
