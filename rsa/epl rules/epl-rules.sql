@RSAAlert(oneInSeconds=0, identifiers={"ip_src"})
SELECT * FROM Event(
  (
    medium = 1 AND tcp_dstport = 22
    AND NOT ip_src = "200.251.129.0/24"
  )).std:groupwin(ip_src).win:time_length_batch(300 sec, 10) GROUP BY ip_src HAVING COUNT(*) = 10;
