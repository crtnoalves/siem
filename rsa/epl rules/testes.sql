@RSAAlert(oneInSeconds=0, identifiers={"ip_src"})
SELECT * FROM Event(
(medium = 1 AND tcp_dstport = 22 AND ip_src NOT REGEXP "200\.251\.129\.[0-9]{1,3}")).win:time(5 minutes)
  MATCH_RECOGNIZE (
  PARTITION BY ip_src
  MEASURES E1 as e1_data , E2 as e2_data
  PATTERN (E1 E2)
  DEFINE
  E1 as (E1.tcp_dstport = 22 AND E1.direction IN ( 'inbound' )),
  E2 as (isNotOneOfIgnoreCase(E2.action,{ 'accept' })));

@RSAAlert(oneInSeconds=0, identifiers={"ip_src"})
SELECT * FROM Event(
(medium = 1 AND tcp_dstport = 22 AND ip_src NOT REGEXP "2xx\.2xx\.1xx\.[0-9]{1,3}")).win:time(5 minutes)
MATCH_RECOGNIZE (
PARTITION BY ip_src
MEASURES E1 as e1_data , E2 as e2_data
PATTERN (E1 E2)
DEFINE
E1 as (E1.tcp_dstport = 22 AND E1.direction IN ( 'inbound' )),
E2 as (isNotOneOfIgnoreCase(E2.action,{ 'accept' })));
